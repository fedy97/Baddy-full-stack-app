const Message = require('../models/message');
const User = require('../models/user');
const handlerFactory = require('../controllers/handlerFactory');
const AppError = require('../utils/appError');
const catchAsync = require('../utils/catchAsync')

const setIds = catchAsync(async (req, res, next) => {
    req.body.user = req.user;
    req.body.userMessaged = await User.findOne({username: req.body.userMessaged});
    next();
});

const checkIfSameUser = async (req, res, next) => {
    if (req.user.role !== 'admin' && req.body.userMessaged.username === req.user.username)
        return next(new AppError(`You cannot write a message for yourself`, 403));
    next();
};

const checkIfItsMe = async (req, res, next) => {
    if (req.user.role !== 'admin' && req.params.username !== req.user.username)
        return next(new AppError(`You cannot see a message belonging to another person`, 403));
    next();
};

//you cannot update or delete someone else message
const checkIfUserIsAuthor = catchAsync(async (req, res, next) => {
    const message = await Message.findById(req.params.id);

    if (req.user.role !== 'admin' && message.user.id !== req.user.id)
        return next(new AppError(`You cannot edit someone's else message`, 403));

    next();
});

const functions = {
    setIds: setIds,
    checkIfUserIsAuthor: checkIfUserIsAuthor,
    checkIfSameUser: checkIfSameUser,
    checkIfItsMe: checkIfItsMe,
    getAllMessages: handlerFactory.getAll(Message),
    getMessage: handlerFactory.getOne(Message),
    createMessage: handlerFactory.createOne(Message),
    updateMessage: handlerFactory.updateOne(Message),
    deleteMessage: handlerFactory.deleteOne(Message),
    getMessagesPerUser: catchAsync(async function (req, res, next) {
        const name = req.params.username;
        const userToFind = await User.findOne({username: name});
        const messages = await Message.find({userMessaged: userToFind}).select('-userMessaged -__v');

        return res.status(200).json({
            status: 'success',
            user: userToFind.username,
            results: messages.length,
            messages: messages
        });
    }),
    getMessagesWrittenByUser: catchAsync(async function (req, res, next) {
        const name = req.params.username;
        const userToFind = await User.findOne({username: name});
        const messages = await Message.find({user: userToFind}).select('-user -__v');

        return res.status(200).json({
            status: 'success',
            user: userToFind.username,
            results: messages.length,
            messages: messages
        });
    })
}

module.exports = functions;
