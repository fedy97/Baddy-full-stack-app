var User = require('../models/user')
var jwt = require('jsonwebtoken');
const AppError = require("../utils/appError");
const catchAsync = require('../utils/catchAsync');

var functions = {
    addNew: catchAsync(async function (req, res, next) {
        if ((!req.body.username) || (!req.body.password)) {
            return next(
                new AppError('Fill both username and password!', 400)
            );
        } else {
            //the body must contain the role, either user or other
            let newUser;
            if (req.body.role == null || req.body.role === 'user')
                newUser = await User.create({
                    username: req.body.username,
                    password: req.body.password,
                    email: req.body.email,
                    registrationToken: req.registrationToken
                });
            //if not a user, it is a "other", so city and phone must be provided
            else if (req.body.phone != null && req.body.city != null)
                newUser = await User.create({
                    username: req.body.username,
                    password: req.body.password,
                    email: req.body.email,
                    phone: req.body.phone,
                    city: req.body.city,
                    role: "other",
                    firstName: req.body.firstName,
                    lastName: req.body.lastName,
                    available: true,
                    registrationToken: req.registrationToken
                });
            else
                return next(new AppError('You have to provide phone and city too!', 400));
            // 3) If everything ok, send token to client
            createSendToken(newUser, 200, req, res);
        }
    }),
    authenticate: catchAsync(async function (req, res, next) {
        const {username, password} = req.body;
        // 1) Check if email and password exist
        if (!username || !password) {
            return next(new AppError('Please provide email and password!', 400));
        }
        // 2) Check if user exists && password is correct
        const user = await User.findOne({username}).select('+password');

        if (!user || !(await user.comparePassword(password, user.password))) {
            return next(new AppError('Incorrect email or password', 401));
        }
        // 3) If everything ok, send token to client
        createSendToken(user, 200, req, res);
    }),
    protect: catchAsync(async (req, res, next) => {
        let token;
        if (
            req.headers.authorization &&
            req.headers.authorization.startsWith('Bearer')
        ) {
            token = req.headers.authorization.split(' ')[1];
        }
        if (!token)
            return next(new AppError('permission denied, invalid token', 401));
        var decoded = jwt.verify(token, process.env.SECRET_JWT);
        //if it proceeds it means the verification was ok
        //now let's check if the user exist or has been deleted
        //decoded is a map of {user,iat,exp}
        const existentUser = await User.findById(decoded.user._id);
        if (!existentUser) {
            return next(
                new AppError('the user that requested the resource does not exist', 401)
            );
        }
        req.user = existentUser;
        next();
    }),
    restrictTo: function (...roles) {
        return (req, res, next) => {
            if (!roles.includes(req.user.role)) {
                return next(new AppError('You do not have permission to perform this action', 403));
            }
            next();
        };
    },
    updatePassword: catchAsync(async (req, res, next) => {
        // 1) Get user from collection
        const user = await User.findById(req.user._id).select('+password');

        // 2) Check if POSTed current password is correct
        if (!(await user.comparePassword(req.body.currentPassword, user.password))) {
            return next(new AppError('Your current password is wrong.', 401));
        }
        // 3) If so, update password
        user.password = req.body.password;
        await user.save();
        // 4) Log user in, send JWT
        createSendToken(user, 200, req, res);
    })
}

const createSendToken = (user, statusCode, req, res) => {
    user.password = undefined;
    const token = jwt.sign({user}, process.env.SECRET_JWT, {
        expiresIn: process.env.JWT_EXPIRES_IN
    });
    return res.status(statusCode).json({status: "success", token: token})
};

module.exports = functions
