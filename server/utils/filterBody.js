exports.filterBody = (...allowedFields) => {
    return (req, res, next) => {
        const newObj = {};
        Object.keys(req.body).forEach(el => {
            let canBeAdded = true;
            if (allowedFields.includes(el)) {
                //cannot become an admin
                if (el === 'role' && req.body.role !== 'other' && req.body.role !== 'user')
                    canBeAdded = false;
                if (canBeAdded) newObj[el] = req.body[el];
            }
        });
        req.body = newObj;
        next();
    }
}
