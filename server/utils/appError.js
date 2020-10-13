class AppError extends Error {
    constructor(message, code) {
        super(message);
        this.statusCode = code;
        this.status = this.statusCode.toString().startsWith('4') ? 'fail' : 'error';
        //so not a bug of my code, but a request error
        this.isOperational = true;

        Error.captureStackTrace(this, this.constructor);
    }
}
module.exports = AppError;
