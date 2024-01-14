const {client} = require('../services/dbService')
const {comparePasswords, errorHandling} = require('../utils/helpers')

async function verifyPassword(req, res, next) {
    let queryResult
    const {id} = res.locals.tokenData
    const {oldPassword} = req.body

    try {
        queryResult = await client.query(`select password_hash
                                          from users
                                          where id = '${id}'`)
    } catch (error) {
        errorHandling('verifyPassword', '', error)
    }

    if (!queryResult.rowCount) {
        return res.status(401).json({
            status: "User doesn't exist",
        })
    }

    const hashedPassword = queryResult.rows[0].password_hash

    const bcryptResult = await comparePasswords(oldPassword, hashedPassword)

    if (!bcryptResult) {
        return res.status(401).json({
            status: 'Wrong password or email',
        })
    }

    next()
}

module.exports = {
    verifyPassword,
}