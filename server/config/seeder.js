const fs = require('fs');
const mongoose = require('mongoose');
const colors = require('colors');
const dotenv = require('dotenv');

// Load env vars
dotenv.config({path: __dirname.split("config")[0] + "config.env"});

// Load models
const User = require('../models/user');
const Review = require("../models/review");

// Connect to DB
mongoose.connect(process.env.DB_URL, {
    useNewUrlParser: true,
    useCreateIndex: true,
    useFindAndModify: false,
    useUnifiedTopology: true
});

// Read JSON files
const users = JSON.parse(
    fs.readFileSync(`${__dirname}/mocked_data/users.json`, 'utf-8')
);
const reviews = JSON.parse(
    fs.readFileSync(`${__dirname}/mocked_data/reviews.json`, 'utf-8')
);

// Import into DB
const importData = async () => {
    try {
        await User.create(users);
        console.log('Users Imported...'.green.inverse);
        await createReviews(reviews);
        console.log('Reviews Imported...'.green.inverse);
        process.exit(0);
    } catch (err) {
        console.error(err);
        process.exit(1);
    }
};

const createReviews = async (reviews) => {
    let listUserIds = await fetchIds();
    for (let i = 0; i < reviews.length; i++) {
        reviews[i].userReviewed = await User.findById(listUserIds[5]);
        reviews[i].user = await User.findById(listUserIds[i + 1]);
    }
    await Review.create(reviews);
}

const fetchIds = async () => {
    let list = [];
    const users = await User.find();
    for (let i = 0; i < users.length; i++)
        list.push(users[i]._id);
    return list;
}

// Delete data
const deleteData = async () => {
    try {
        await User.deleteMany();
        await Review.deleteMany();
        console.log('Data Destroyed...'.red.inverse);
        //process.exit(0);
    } catch (err) {
        console.error(err);
        process.exit(1);
    }
};

const doBoth = async () => {
    try {
        await deleteData();
        await importData();
    } catch (e) {
        console.error(err);
        process.exit(1);
    }
}

if (process.argv[2] === '-i') {
    importData().then(() => {
        process.exit(0);
    })

} else if (process.argv[2] === '-d') {
    deleteData().then(() => {
        process.exit(0);
    });
} else
    doBoth();
