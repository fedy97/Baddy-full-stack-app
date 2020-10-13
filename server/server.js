const app = require('./app');
const dotenv = require('dotenv').config({path: __dirname + "/config.env"});
const port = process.env.PORT || 5000;

app.listen(port, () => {
  console.log(`Listening on port:${port}`);
});
