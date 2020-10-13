const Review = require('../models/review');
const User = require('../models/user');
const handlerFactory = require('../controllers/handlerFactory');
const AppError = require('../utils/appError');
const catchAsync = require('../utils/catchAsync')

const setIds = catchAsync(async (req, res, next) => {
    req.body.user = req.user;
    req.body.userReviewed = await User.findOne({name: req.body.userReviewed});
    next();
});

const checkIfSameUser = async (req, res, next) => {
    if (req.user.role !== 'admin' && req.body.userReviewed.name === req.user.name)
        return next(new AppError(`You cannot write a review for yourself`, 403));
    next();
};

//you cannot update or delete someone else review
const checkIfUserIsAuthor = catchAsync(async (req, res, next) => {
    const review = await Review.findById(req.params.id);

    if (req.user.role !== 'admin' && review.user.id !== req.user.id)
        return next(new AppError(`You cannot edit someone's else review`, 403));

    next();
});

const functions = {
    setIds: setIds,
    checkIfUserIsAuthor: checkIfUserIsAuthor,
    checkIfSameUser: checkIfSameUser,
    getAllReviews: handlerFactory.getAll(Review),
    getReview: handlerFactory.getOne(Review),
    //TODO create a personalized body to pass here  with Review
    sanitizeBody: function (req, res, next) {
        req.body = {
            review: req.body.review,
            rating: req.body.rating,
            user: req.body.user,
            userReviewed: req.body.userReviewed
        };
        next();
    },
    createReview: handlerFactory.createOne(Review),
    updateReview: handlerFactory.updateOne(Review),
    deleteReview: handlerFactory.deleteOne(Review),
    getReviewsPerUser: catchAsync(async function (req, res, next) {
        const name = req.params.name;
        const userToFind = await User.findOne({name});
        const reviews = await Review.find({userReviewed: userToFind}).select('-userReviewed -__v');

        return res.status(200).json({
            status: 'success',
            user: userToFind.name,
            results: reviews.length,
            reviews: reviews
        });
    })
}

module.exports = functions;
