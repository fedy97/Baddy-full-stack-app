const mongoose = require('mongoose');
const fcmAdmin = require('firebase-admin');
const User = require('./user');
//
const reviewSchema = new mongoose.Schema(
    {
        review: {
            type: String,
            required: [true, 'Review can not be empty'],
            maxlength: 1000,
        },
        rating: {
            type: Number,
            min: [1, 'A review rating must be between 1.0 and 5.0'],
            max: [5, 'A review rating must be between 1.0 and 5.0'],
            required: [true, 'you must specify a rating value']
        },
        createdAt: {
            type: Date,
            default: Date.now(),
        },
        userReviewed: {
            type: mongoose.Schema.ObjectId,
            ref: 'User',
            required: [true, 'Review must be addressed to an existing user'],
        },
        user: {
            type: mongoose.Schema.ObjectId,
            ref: 'User',
            required: [true, 'Review must belong to a user'],
        },
    },
    {
        toJSON: {virtuals: true},
        toObject: {virtuals: true},
    }
);

reviewSchema.index({userReviewed: 1, user: 1}, {unique: true});

reviewSchema.pre(/^find/, function (next) {
    this.populate({
        path: 'user',
        select: 'username photo',
    });
    this.populate({
        path: 'userReviewed',
        select: 'username photo',
    });
    next();
});

reviewSchema.statics.calcAverageRatings = async function (userReviewed) {
    // this -> current Model
    //will match all reviews written for that particular userReviewed id
    const val = mongoose.Types.ObjectId(userReviewed.id);
    const stats = await this.aggregate([
        {
            $match: {userReviewed: val},
        },
        {
            $group: {
                _id: '$userReviewed',
                nRating: {$sum: 1},
                avgRating: {$avg: '$rating'},
            },
        },
    ]);
    if (stats.length > 0) {
        await User.findByIdAndUpdate(userReviewed.id, {
            ratingsQuantity: stats[0].nRating,
            ratingsAverage: stats[0].avgRating,
        });
    } else {
        await User.findByIdAndUpdate(userReviewed.id, {
            ratingsQuantity: 0,
            ratingsAverage: 0.0,
        });
    }
};
/**
 * when a new review is written, it is triggered this event
 * in order to update the avg rating on the userReviewed model
 */
reviewSchema.post('save', async function () {
    // this -> current Review document, this.constructor -> Review model
    let message = {
        notification: {
            title: `${this.user.username} has just reviewed your profile`,
            body: this.review
        },
        token: this.userReviewed.registrationToken
    };

    // Send a message to the device corresponding to the provided
    // registration token.
    fcmAdmin.messaging().send(message)
        .then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
        })
        .catch((error) => {
            console.log('Error sending message:', error);
        });

    await this.constructor.calcAverageRatings(this.userReviewed);
});

// Updating Reviews: findByIdAndUpdate -> findOneAndUpdate({_id: id})
// Deleting Reviews: findByIdAndDelete -> findOneAndDelete({_id: id})
reviewSchema.post(/^findOneAnd/, async function (doc, next) {
    // doc -> review document, doc.constructor -> Review model
    await doc.constructor.calcAverageRatings(doc.userReviewed);
    next();
});

const Review = mongoose.model('Review', reviewSchema);

module.exports = Review;
