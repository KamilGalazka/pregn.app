const bcrypt = require("bcrypt");

async function verifyPassword(req, res, next) {
    let queryResult
    const {id} = res.locals.tokenData
    const {oldPassword} = req.body

    try {
        queryResult = await client.query(`select password_hash
                                          from users
                                          where id = '${id}'`)
    } catch (error) {
        console.log('verifyPassword error', error)
    }

    if (!queryResult.rowCount) {
        return res.status(401).json({
            status: "User doesn't exist",
        })
    }

    const hashedPassword = queryResult.rows[0].password_hash
    let bcryptResult

    try {
        bcryptResult = await bcrypt.compare(oldPassword, hashedPassword)
    } catch (error) {
        console.log('/api/user/login bcrypt error', error)
    }

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