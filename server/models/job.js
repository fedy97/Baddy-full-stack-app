const mongoose = require('mongoose')
const Schema = mongoose.Schema;

const jobSchema = new Schema(
    {
        isActive: {
            type: Boolean,
            default: true
        },
        createdAt: {
            type: Date,
            default: Date.now
        },
        user: {
            type: mongoose.Schema.ObjectId,
            ref: 'User',
            required: true
        },
        price: {
            type: Number,
            required: [true, 'A job must have a price']
        },
        description: {
            type: String,
            trim: true
        },
        startDate: {
            type: Date,
            default: Date.now
        },
        endDate: {
            type: Date,
        },
        city: {
            type: String,
            required: [true, 'A job must be located somewhere']
        }
    },
    {
        //in order to display virtuals and populate in json and not in ObjectId
        toJSON: {virtuals: true},
        toObject: {virtuals: true}
    }
);

module.exports = mongoose.model('Job', jobSchema);
