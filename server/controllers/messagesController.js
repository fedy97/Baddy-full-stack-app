const Message = require('../models/message');
const User = require('../models/user');
const handlerFactory = require('../controllers/handlerFactory');
const AppError = require('../utils/appError');
const catchAsync = require('../utils/catchAsync')

const setIds = catchAsync(async (req, res, next) => {
    req.body.sender = req.sender;
    req.body.recipient = await User.findOne({username: req.body.recipient});
    next();
});

const checkIfSameUser = async (req, res, next) => {
    if (req.user.role !== 'admin' && req.body.sender.username === req.recipient.username)
        return next(new AppError(`You cannot write a message to yourself`, 403));
    next();
};


const functions = {
    setIds: setIds,
    checkIfSameUser: checkIfSameUser,
    getAllMessages: handlerFactory.getAll(Message),
    getMessage: handlerFactory.getOne(Message),
    createMessage: handlerFactory.createOne(Message),
    updateMessage: handlerFactory.updateOne(Message),
    deleteMessage: handlerFactory.deleteOne(Message),
    getMessagesOfUser: catchAsync(async function (req, res, next) {
        const name = req.params.username;
        const userToFind = await User.findOne({username: name});
        const messages = await Message.find({recipient: userToFind}).select('-recipient -__v');

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
        const messages = await Message.find({sender: userToFind}).select('-sender -__v');

        return res.status(200).json({
            status: 'success',
            user: userToFind.username,
            results: messages.length,
            reviews: messages
        });
    })
}

module.exports = functions;
