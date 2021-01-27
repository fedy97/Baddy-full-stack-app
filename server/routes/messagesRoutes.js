const express = require('express');

const messageController = require('../controllers/messagesController');
const authController = require('../controllers/authController');
const {filterBody} = require("../utils/filterBody");

const router = express.Router({mergeParams: true});

//for every actions we must be authenticated
router.use(authController.protect);

// URL/api/v1/messages
router
    .route('/')
    .get(authController.restrictTo('admin'), messageController.getAllMessages)
    .post(
        authController.restrictTo('user', 'admin'),
        messageController.setIds,
        messageController.checkIfSameUser,
        filterBody('message', 'user', 'userMessaged'),
        messageController.createMessage
    );

router.route('/user/:username').get(messageController.checkIfItsMe, messageController.getMessagesPerUser);
router.route('/user/mymessages/:username').get(messageController.getMessagesWrittenByUser);

//router
//    .route('/:id')
//    .get(messageController.getMessage)
//    .patch(
//        authController.restrictTo('user', 'admin'),
//        messageController.checkIfUserIsAuthor,
//        filterBody('message', 'rating', 'user', 'userMessaged'),
//        messageController.updateMessage
//    )
//    .delete(
//        authController.restrictTo('user', 'admin'),
//        messageController.checkIfUserIsAuthor,
//        messageController.deleteMessage
//    );

module.exports = router;
