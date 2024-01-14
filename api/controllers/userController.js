const {client} = require('../services/dbService')
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const saltRounds = 10

const createNewAccount = async (req, res) => {
    const {
        name,
        lastname,
        email,
        password,
    } = req.body
    let bcryptResult
    let queryResult

    try {
        bcryptResult = await bcrypt.hash(password, saltRounds)
    } catch (error) {
        console.log('/api/user/create bcrypt error', error)
    }

    if (!bcryptResult)
        res.status(500)

    try {
        queryResult = await client.query(`insert into users (name, lastname, email, password_hash, role)
                                          values ('${name}', '${lastname}', '${email}', '${bcryptResult}', 'user')`)
    } catch (error) {
        console.log('/api/user/create query error', error)
    }

    if (queryResult) {
        res.status(201).json({
            status: 'User created',
        })
    } else {
        res.status(409).json({
            status: 'User already exists',
        });
    }
}

const getUserInformation = async (req, res) => {
    let queryResult

    const {id: userId} = res.locals.tokenData

    try {
        queryResult = await client.query(`select name, lastname, email, role
                                          from users
                                          where id = ${userId}`)
    } catch (error) {
        console.log('/api/user/info error', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows[0],
    })
}

const changeUserData = async (req, res) => {
    let queryResult
    const {name, lastname, email} = req.body

    const {id: userId} = res.locals.tokenData

    try {
        queryResult = await client.query(`update users
                                          set (name, lastname, email, updated_at) = ('${name}', '${lastname}', '${email}', NOW())
                                          where id = ${userId} returning *`)
    } catch (error) {
        console.log('/api/user/change/data error', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows,
    })
}

const changeUserPassword = async (req, res) => {
    const {newPassword} = req.body
    const {id: userId} = res.locals.tokenData

    let bcryptResult

    try {
        bcryptResult = await bcrypt.hash(newPassword, saltRounds)
    } catch (error) {
        console.log('/api/user/create bcrypt error', error)
    }

    if (!bcryptResult)
        res.status(500)

    try {
        await client.query(`update users
                                          set (password_hash, updated_at) = ('${bcryptResult}', NOW())
                                          where id = ${userId}`)
    } catch (error) {
        console.log('/api/user/change/password update error', error)
    }

    res.status(200).json({
        status: 'OK',
    })
}

const deleteUserAccount = async (req, res) => {
    const {id: userId} = res.locals.tokenData

    try {
        await client.query(`delete
                            from users
                            where id = ${userId}`)
    } catch (error) {
        console.log('api/user/delete from users error', error)
    }

    try {
        await client.query(`delete
                            from refresh_tokens
                            where user_id = ${userId}`)
    } catch (error) {
        console.log('api/user/delete from refresh_tokens error', error)
    }

    try {
        await client.query(`delete
                            from calendar
                            where user_id = ${userId}`)
    } catch (error) {
        console.log('api/user/delete from calendar error', error)
    }

    res.status(200).json({
        status: 'OK',
    })
}

const loginToAccount = async (req, res) => {
    const {
        email,
        password,
    } = req.body
    let queryResult

    try {
        queryResult = await client.query(`select id, password_hash, role
                                          from users
                                          where email = '${email}'`)
    } catch (error) {
        console.log('/api/user/login error', error)
    }

    if (!queryResult.rowCount) {
        return res.status(401).json({
            status: "User doesn't exist",
        })
    }

    const hashedPassword = queryResult.rows[0].password_hash
    const userRole = queryResult.rows[0].role
    const userId = queryResult.rows[0].id
    let bcryptResult

    try {
        bcryptResult = await bcrypt.compare(password, hashedPassword)
    } catch (error) {
        console.log('/api/user/login bcrypt error', error)
    }

    if (!bcryptResult) {
        return res.status(401).json({
            status: 'Wrong password or email',
        })
    }

    const accessToken = jwt.sign({id: userId}, process.env.TOKEN_SECRET, {expiresIn: 86400})
    const refreshToken = jwt.sign({id: userId}, process.env.REFRESH_TOKEN_SECRET, {expiresIn: 525600})

    try {
        client.query(`update users
                      set refresh_token='${refreshToken}'
                      where email = '${email}'`)
    } catch (error) {
        console.log('/api/user/login save refresh_token to db error', error)
    }

    res.cookie('JWT', accessToken, {
        maxAge: 86400,
        httpOnly: true,
    }).status(200).json({
        status: 'Login successful',
        role: userRole,
        token: accessToken,
        refreshToken,
    })
}

const refreshUserToken = async (req, res) => {
    let {refreshToken} = req.body
    let queryResult
    let isRefreshTokenValid
    let newAccessToken

    refreshToken = refreshToken.split(' ')[1]

    if (!refreshToken) return res.status(401)

    const decodedRefreshToken = jwt.decode(refreshToken)
    const {id} = decodedRefreshToken

    try {
        queryResult = await client.query(`select rt.refresh_token
                                          from users
                                                   join refresh_tokens as rt on ${id} = rt.user_id`)
    } catch (error) {
        console.log('/api/user/refresh error', error)
    }

    if (!queryResult || refreshToken !== queryResult.rows[0].refresh_token) return res.status(403)

    try {
        isRefreshTokenValid = await jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET)
    } catch (error) {
        console.log('/api/user/refresh verify error', error)
    }

    if (!isRefreshTokenValid) return res.status(403)

    try {
        newAccessToken = await jwt.sign({id: id}, process.env.TOKEN_SECRET, {expiresIn: 86400})
    } catch (error) {
        console.log('/api/user/refresh sign error', error)
    }

    if (!newAccessToken) return res.status(403)

    res.cookie('JWT', newAccessToken, {
        maxAge: 86400,
        httpOnly: true,
    }).status(200).json({
        status: 'OK',
    })
}

module.exports = {
    createNewAccount,
    getUserInformation,
    changeUserData,
    changeUserPassword,
    deleteUserAccount,
    loginToAccount,
    refreshUserToken,
}