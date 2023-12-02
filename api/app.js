const dotenv = require('dotenv')
const express = require('express')
const cors = require('cors')
const {Client} = require('pg')
const bodyParser = require('body-parser')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const cookieParser = require("cookie-parser")

dotenv.config()

let client
const app = express()
const port = process.env.PORT || 3000
const saltRounds = 10

if (process.env.NODE_ENV === 'production') {
    client = new Client({
        user: 'docker',
        host: 'db',
        database: 'pregnapp',
        password: 'postgres',
        port: 5432,
    })
} else {
    client = new Client({
        user: 'postgres',
        host: 'localhost',
        database: 'pregnapp',
        password: 'kamil',
        port: 5433,
    })
}

app.use(cors({origin: '*'}))
app.use(cookieParser())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

client.connect()
    .then(() => console.log('Connected to database'))
    .catch(err => console.error('Connection to database failed:', err))

process.on('exit', () => {
    client.end()
})

app.listen(port, () => {
    console.log('Server started...')
})

app.post('/api/user/create', async (req, res) => {
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
})

app.post('/api/user/login', async (req, res) => {
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
        res.status(401).json({
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
})

app.post('/api/user/refresh', async (req, res) => {
    let {refreshToken} = req.body
    let queryResult
    let isRefreshTokenValid
    let newAccessToken

    refreshToken = refreshToken.split(' ')[1]

    if (!refreshToken) return res.status(401)

    const decodedRefreshToken = jwt.decode(refreshToken)
    const {id} = decodedRefreshToken

    try {
        queryResult = await client.query(`select refresh_token
                                          from users
                                          where id = ${id}`)
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
})

app.get('/api/navigation', async (req, res) => {
    let queryResult

    try {
        queryResult = await client.query('select name, route from navigation')
    } catch (error) {
        console.log('/api/navigation error', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows,
    })
})
