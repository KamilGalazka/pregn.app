const express = require('express')
const cors = require('cors')
const {Client} = require('pg')
const bodyParser = require('body-parser')
const bcrypt = require('bcrypt')

const app = express()
const port = process.env.PORT || 3000
const saltRounds = 10
let client

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

app.post('/api/user/create', (req, res) => {
    const {
        name,
        lastname,
        email,
        password,
    } = req.body

    bcrypt.hash(password, saltRounds, (err, hash) => {
        if (hash) {
            client.query(`insert into users (name, lastname, email, password_hash, role, verification_token,
                                             reset_password_token)
                          values ('${name}', '${lastname}', '${email}', '${hash}', 'user', 't1',
                                  't2')`, (err, result) => {
                if (err) {
                    console.error('Błąd podczas zapytania do bazy danych:', err);
                    res.status(500).send(err.detail);
                } else {
                    res.status(200).json({
                        status: 'User created',
                    });
                }
            })
        }
    })
})

app.get('/api/user/login', (req, res) => {
    const {
        email,
        password,
    } = req.body

    client.query(`select email
                  from users
                  where email = '${email}'`, (err, result) => {
        if (err || !result.rowCount) {
            res.status(500).json({
                status: 'Wrong password or email'
            })
        }
    })

    client.query(`select password_hash
                  from users
                  where email = '${email}'`, (err, result) => {
        const hashedPassword = result.rows[0].password_hash

        bcrypt.compare(password, hashedPassword, (err, result) => {
            if (result) {
                res.status(200).json({
                    status: 'Login successful'
                })
            } else {
                res.status(500).json({
                    status: 'Wrong password or email'
                })
            }
        })
    })
})

app.get('/api/navigation', (req, res) => {
    res.status(200).json({
        status: 'OK',
        response: [
            {
                name: "Etapy ciąży",
                path: "/path1",
            },
            {
                name: "Zdrowie",
                path: "/path4"
            },
            {
                name: "Wyprawka",
                path: "/path2",
            },
            {
                name: "Logowanie",
                path: "/login",
            },
            {
                name: "Rejestracja",
                path: "/register",
            },
        ],
    })
})
