const express = require('express');
const authController = require('../controllers/authController');
const usersController = require('../controllers/usersController');
const {filterBody} = require("../utils/filterBody");
const router = express.Router();
//endpoint: api/v1/users
router.post('/signup', authController.addNew);
router.post('/login', authController.authenticate);

//to perform actions from here on you must be logged in
//we also have the property req.user available from now on
router.use(authController.protect);

router.get('/me', usersController.me);

router.patch('/updateDetails',
    filterBody('photo', 'email', 'firstName', 'lastName', 'phone', 'gender', 'city', 'role', 'available', 'birth', 'nationality'),
    //usersController.uploadUserPhoto,
    //usersController.resizeUserPhoto,
    usersController.updateDetails);

router.patch('/updateMyPassword', authController.updatePassword);

router.get('/available', usersController.getAvailableUsers);

//to perform actions from here on you must be admin
router.use(authController.restrictTo('admin'));

router.route('/').get(usersController.getAllUsers);
router.route('/:id').get(usersController.getUser);


module.exports = router;
