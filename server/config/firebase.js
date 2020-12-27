const fcmAdmin = require('firebase-admin');
const serviceAccount = require("../baddy-f34f0-firebase-adminsdk-sjzl7-2d48ddf636.json");

const initFirebase = () => {
    try {
        fcmAdmin.initializeApp({
            credential: admin.credential.cert(serviceAccount),
            databaseURL: "https://baddy-f34f0.firebaseio.com"
        });
    }
    catch (err) {
        console.log(err)
        process.exit(1)
    }
}

module.exports = initFirebase
