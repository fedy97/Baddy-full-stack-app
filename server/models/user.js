const mongoose = require('mongoose')
const Schema = mongoose.Schema;
const bcrypt = require('bcrypt');
const validator = require('validator');

const userSchema = new Schema({
        firstName: String,
        lastName: String,
        price: Number,
        gender: {
            type: String
        },
        birth: {
            type: Date
        },
        available: {
            type: Boolean,
            default: false
        },
        nationality: String,
        username: {
            type: String,
            required: [true, 'Please tell us your username'],
            unique: true,
            trim: true
        },
        password: {
            type: String,
            required: [true, 'Please provide a password'],
            minlength: [6, 'Your password is too short'],
            select: false
        },
        role: {
            enum: ['user', 'admin', 'other'],
            type: String,
            default: 'user'
        },
        email: {
            type: String,
            required: [true, 'Please provide your email'],
            unique: true,
            lowercase: true,
            trim: true,
            validate: [validator.isEmail, 'Please provide a valid email']
        },
        createdAt: {
            type: Date,
            default: Date.now
        },
        photo: {
            type: String,
            default: 'default.jpg'
        },
        phone: {
            type: String
        },
        city: {
            type: String,
            set: (city) => city.toString().toUpperCase()
        },
        ratingsAverage: {
            type: Number,
            min: [1, 'Rating must be above 1.0'],
            max: [5, 'Rating must be below 5.0']
        },
        ratingsQuantity: {
            type: Number,
            default: 0
        },
        registrationToken: {
            type: String,
            trim: true
        },
        lat: {
            type: Number,
            strict: false
        },
        long: {
            type: Number,
            strict: false
        }
    },
    {
        toJSON: {virtuals: true},
        toObject: {virtuals: true},
    }
);

userSchema.index({ratingsAverage: -1});

// Virtual Populate reviews, it is not stored, the field will be added virtually
userSchema.virtual('reviews', {
    ref: 'Review',
    foreignField: 'userReviewed',
    localField: '_id',
});

userSchema.pre('save', async function (next) {
    this.username = this.username.split(' ').join('');
    this.password = await bcrypt.hash(this.password, 12);
    next();
});

userSchema.methods.comparePassword = async function (candidatePassword, userPassword) {
    return await bcrypt.compare(candidatePassword, userPassword);
}

module.exports = mongoose.model('User', userSchema)
