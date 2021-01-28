const mongoose = require('mongoose');
const fcmAdmin = require('firebase-admin');

const messageSchema = new mongoose.Schema(
    {
        message: {
            type: String,
            required: [true, 'Message can not be empty'],
            maxlength: 1000,
        },
        createdAt: {
            type: Date,
            default: Date.now(),
        },
        userMessaged: {
            type: mongoose.Schema.ObjectId,
            ref: 'User',
            required: [true, 'Message must be addressed to an existing user'],
        },
        user: {
            type: mongoose.Schema.ObjectId,
            ref: 'User',
            required: [true, 'Message must belong to a user'],
        },
    },
    {
        toJSON: {virtuals: true},
        toObject: {virtuals: true},
    }
);

messageSchema.pre(/^find/, function (next) {
    this.populate({
        path: 'user',
        select: 'username photo',
    });
    this.populate({
        path: 'userMessaged',
        select: 'username photo',
    });
    next();
});

messageSchema.post('save', async function () {
    let message = {
        notification: {
            title: `${this.user.username} has just sent you a message`,
            body: this.message
        },
        token: this.userMessaged.registrationToken
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
});

const Message = mongoose.model('Message', messageSchema);

module.exports = Message;
