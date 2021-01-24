const mongoose = require('mongoose');
const fcmAdmin = require('firebase-admin');
const User = require('./user');

const reviewSchema = new mongoose.Schema(
    {
        title: {
            type: String,
            maxlength: 20
        },
        body: {
            type: String,
            required: [true, 'Message cannot be empty'],
            maxlength: 1000,
        },
        createdAt: {
            type: Date,
            default: Date.now(),
        },
        sender: {
            type: mongoose.Schema.ObjectId,
            ref: 'User',
            required: [true, 'A message must have a sender'],
        },
        recipient: {
            type: mongoose.Schema.ObjectId,
            ref: 'User',
            required: [true, 'A message must have a receiver'],
        },
    },
    {
        toJSON: {virtuals: true},
        toObject: {virtuals: true},
    }
);

reviewSchema.index({sender: 1, recipient: 1, createdAt: 1}, {unique: true});

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

/**
 * when a new review is written, it is triggered this event
 * in order to update the avg rating on the userReviewed model
 */
reviewSchema.post('save', async function () {
    // this -> current Review document, this.constructor -> Review model
    let message = {
        notification: {
            title: `${this.user.username} has just reviewed your profile`,
            body: this.body
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

const Review = mongoose.model('Message', reviewSchema);

module.exports = Review;
