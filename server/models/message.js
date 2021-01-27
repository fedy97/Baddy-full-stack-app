const mongoose = require('mongoose');
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

const Message = mongoose.model('Message', messageSchema);

module.exports = Message;
