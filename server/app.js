const express = require('express');
const morgan = require('morgan');
const helmet = require('helmet');
const cors = require('cors');
const connectDb = require('./config/db')
const dotenv = require('dotenv').config({path: __dirname + "/config.env"});
const {globalErrorHandler, notFound} = require('./controllers/errorController')
const usersRoutes = require('./routes/usersRoutes');
const reviewsRoutes = require('./routes/reviewsRoutes');

const app = express();

connectDb();

if (process.env.NODE_ENV === 'development')
    app.use(morgan('dev'))
//TODO add middlewares against web attacks
app.use(helmet());
app.use(cors());
//
app.use(express.json({ limit: '10kb' }));
app.use(express.urlencoded({ extended: true, limit: '10kb' }));

app.get('/', (req, res) => {
    res.json({
        message: '🦄🌈✨👋🌎🌍🌏✨🌈🦄'
    });
});

app.use('/api/v1/users', usersRoutes);
app.use('/api/v1/reviews', reviewsRoutes);
//TODO add other routes here

app.use(notFound);

app.use(globalErrorHandler);

module.exports = app;
