const mongoose = require('mongoose')

const connectDB = () => {
    try {
        mongoose.connect(process.env.DB_URL, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
            useFindAndModify: false
        }).then(() => console.log('DB connection successful'));
    }
    catch (err) {
        console.log(err)
        process.exit(1)
    }
}

module.exports = connectDB
