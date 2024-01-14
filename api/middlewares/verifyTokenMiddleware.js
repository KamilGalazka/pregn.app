const jwt = require("jsonwebtoken");

async function verifyToken(req, res, next) {
    const bearerToken = req.headers.authorization
    let tokenData

    const token = bearerToken.split(' ')[1]

    try {
        tokenData = await jwt.verify(token, process.env.TOKEN_SECRET)
    } catch (error) {
        console.log('/api/user/refresh verify error', error)

        return res.status(401).json({
            status: 'invalid token',
        })
    }

    res.locals.tokenData = tokenData
    next()
}

module.exports = {
    verifyToken,
}