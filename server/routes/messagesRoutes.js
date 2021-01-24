const express = require('express');

const messagesController = require('../controllers/messagesController');
const authController = require('../controllers/authController');
const {filterBody} = require("../utils/filterBody");

const router = express.Router({mergeParams: true});

//for every actions we must be authenticated
router.use(authController.protect);

// URL/api/v1/message
router
    .route('/')
    .get(messagesController.getAllMessages)
    .post(
        authController.restrictTo('user', 'admin'),
        messagesController.setIds,
        messagesController.checkIfSameUser,
        filterBody('body', 'sender', 'recipient'),
        messagesController.createReview
    );

router.route('/user/:username').get(messagesController.getMessagesOfUser);
router.route('/user/mymessages/:username').get(messagesController.getMessagesWrittenByUser);

router
    .route('/:id')
    .get(messagesController.getMessage)
    .patch(
        authController.restrictTo('user', 'admin'),
        messagesController.checkIfUserIsAuthor,
        filterBody('body', 'sender', 'recipient'),
        messagesController.updateMessage
    )
    .delete(
        authController.restrictTo('user', 'admin'),
        messagesController.checkIfUserIsAuthor,
        messagesController.deleteMessage
    );

module.exports = router;
