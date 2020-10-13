const factory = require('../controllers/handlerFactory');
const User = require('../models/user');
const catchAsync = require('../utils/catchAsync');

const functions = {
    getAllUsers: factory.getAll(User),
    getUser: factory.getOne(User),
    me: catchAsync(async function (req, res, next) {
        return res.status(200).json({status: "success", user: req.user});
    }),
    updateDetails: catchAsync(async (req, res, next) => {
        //Filtered out unwanted fields names that are not allowed to be updated
        const filteredBody = filterObj(req.body, 'email', 'firstName', 'lastName', 'phone', 'address');

        //if (req.file) filteredBody.photo = req.file.filename;

        const user = await User.findByIdAndUpdate(req.user._id, filteredBody, {
            new: true,
            runValidators: true,
        });
        req.user = user;
        res.status(200).json({
            success: true,
            data: user
        });
    })
}

const filterObj = (obj, ...allowedFields) => {
    const newObj = {};
    Object.keys(obj).forEach(el => {
        if (allowedFields.includes(el)) {
            newObj[el] = obj[el];
        }
    });

    return newObj;
};

module.exports = functions;
