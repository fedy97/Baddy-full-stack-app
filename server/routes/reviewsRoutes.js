const express = require('express');

const reviewController = require('../controllers/reviewsController');
const authController = require('../controllers/authController');

const router = express.Router({mergeParams: true});

//for every actions we must be authenticated
router.use(authController.protect);

// URL/api/v1/reviews
router
    .route('/')
    .get(reviewController.getAllReviews)
    .post(
        authController.restrictTo('user', 'admin'),
        reviewController.setIds,
        reviewController.checkIfSameUser,
        reviewController.sanitizeBody,
        reviewController.createReview
    );

router.route('/user/:name').get(reviewController.getReviewsPerUser);

router
    .route('/:id')
    .get(reviewController.getReview)
    .patch(
        authController.restrictTo('user', 'admin'),
        reviewController.checkIfUserIsAuthor,
        reviewController.sanitizeBody,
        reviewController.updateReview
    )
    .delete(
        authController.restrictTo('user', 'admin'),
        reviewController.checkIfUserIsAuthor,
        reviewController.deleteReview
    );

module.exports = router;
