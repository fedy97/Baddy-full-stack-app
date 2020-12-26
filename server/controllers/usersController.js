const factory = require('../controllers/handlerFactory');
const User = require('../models/user');
const catchAsync = require('../utils/catchAsync');
const AppError = require("../utils/appError");
const {filterBody} = require("../utils/filterBody");

const functions = {
    getAllUsers: factory.getAll(User),
    getUser: factory.getOne(User),
    me: catchAsync(async function (req, res, next) {
        return res.status(200).json({status: "success", user: req.user});
    }),
    getAvailableUsers: catchAsync(async function (req, res, next) {
        //find only available excluding myself
        let users = await User.find({available: true, username: {$ne: req.user.username}}).select('-email');
        return res.status(200).json({
            status: "success",
            length: users.length,
            data: users
        })
    }),
    updateDetails: catchAsync(async (req, res, next) => {
        if (req.body.photo == null) {
            //if you become 'other' you must specify phone and city
            if (req.body.role != null && req.body.role === 'other' && req.body.available) {
                if (req.body.phone == null && req.user.phone == null)
                    return next(new AppError('you must specify your phone number!', 400));
                if (req.body.city == null && req.user.city == null)
                    return next(new AppError('you must specify your city!', 400));
            }
        }

        const user = await User.findByIdAndUpdate(req.user._id, req.body, {
            new: true,
            runValidators: true,
        });
        req.user = user;
        res.status(200).json({
            success: true,
            data: user
        });
    }),

    updateRegistrationToken: catchAsync(async (req, res, next) => {
        if (req.body.registrationToken == null) {
            return next(new AppError('Registration token must be properly valued', 400));
        }
        const validRegistrationToken = {registrationToken: req.body.registrationToken}
        await User.findByIdAndUpdate(req.user._id, validRegistrationToken, {
            runValidators: true
        });

        res.status(200).json({
            success: true
        });
    })
}

module.exports = functions;
