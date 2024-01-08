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
})

app.get('/api/navigation', async (req, res) => {
    let queryResult

    try {
        queryResult = await client.query('select * from navigation')
    } catch (error) {
        console.log('/api/navigation error', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows,
    })
})

app.get('/api/stage/:week', async (req, res) => {
    const week = req.params.week
    let queryResult

    try {
        queryResult = await client.query(`select *
                                          from pregnancy_stages
                                          where week = ${week}`)
    } catch (error) {
        console.log('api/stage/:week error', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows[0],
    })
})

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

app.get('/api/calendar', verifyToken, async (req, res) => {
    let queryResult

    const {id: userId} = res.locals.tokenData

    try {
        queryResult = await client.query(`select c.id, c.title, c.content, c.priority, c.date
                                          from users
                                                   join calendar as c on ${userId} = c.user_id`)
    } catch (error) {
        console.log('/api/calendar get data error', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows,
    })
})

app.post('/api/calendar/add', verifyToken, async (req, res) => {
    const {id: userId} = res.locals.tokenData
    const {title, content, priority, date} = req.body

    try {
        await client.query(`insert into calendar (user_id, title, content, priority, date)
                            values (${userId}, '${title}', '${content}', ${priority}, '${date}');`)
    } catch (error) {
        console.log('/api/calendar/add data error', error)

        return res.status(404).json({
            status: "NOK note not added",
        })
    }

    res.status(201).json({
        status: 'OK',
    })
})

app.put('/api/calendar/change', verifyToken, async (req, res) => {
    let queryResult
    const {noteId, title, content, priority, date} = req.body

    try {
        queryResult = await client.query(`update calendar
                                          set (title, content, priority, date) = ('${title}', '${content}', ${priority}, '${date}')
                                          where calendar.id = ${noteId} returning *`)
    } catch (error) {
        console.log('/api/calendar/change data error', error)

        return res.status(404).json({
            status: "NOK note not updated",
        })
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows[0],
    })
})

app.delete('/api/calendar/delete', verifyToken, async (req, res) => {
    const {noteId} = req.body

    try {
        await client.query(`delete
                            from calendar
                            where calendar.id = ${noteId}`)
    } catch (error) {
        console.log('/api/calendar/delete data error', error)

        return res.status(404).json({
            status: "NOK note not deleted",
        })
    }

    res.status(200).json({
        status: 'OK',
    })
})

app.get('/api/article/:type', async (req, res) => {
    const categoryType = req.params.type
    let queryResult

    try {
        queryResult = await client.query(`select id,
                                                 title_pl,
                                                 title_en,
                                                 description_pl,
                                                 description_en,
                                                 image_name,
                                                 published,
                                                 published_date
                                          from article
                                          where article.category = '${categoryType}'`)
    } catch (error) {
        console.log('/api/article error', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows,
    })
})

app.get('/api/article/:type/:id', async (req, res) => {
    const {id, type: categoryType} = req.params
    let queryResult

    try {
        queryResult = await client.query(`select *
                                          from article
                                          where article.category = '${categoryType}'
                                            and article.id = ${id}`)
    } catch (error) {
        console.log('/api/article/:type/:id error', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows[0],
    })
})