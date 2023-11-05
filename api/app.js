const express = require('express')
const cors = require('cors');
const {Client} = require('pg')
const bodyParser = require('body-parser')

const app = express()
const port = process.env.PORT || 3000
const client = new Client({
    user: 'docker',
    host: 'db',
    database: 'pregnapp',
    password: 'postgres',
    port: 5432,
})

app.use(cors({origin: '*'}))

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

client.connect()
    .then(() => console.log('Połączono z bazą danych PostgreSQL'))
    .catch(err => console.error('Błąd podczas łączenia z bazą danych:', err));

process.on('exit', () => {
    client.end();
})

app.listen(port, () => {
    console.log('test2')
})

app.post('/api/user/create', (req, res) => {
    const {
        name,
        lastname,
        email,
        password,
    } = req.body

    client.query(`insert into users (name, lastname, email, password_hash, role, verification_token,
                                     reset_password_token)
                  values ('${name}', '${lastname}', '${email}', '${password}', 'user', 't1', 't2')`, (err, result) => {
        if (err) {
            console.error('Błąd podczas zapytania do bazy danych:', err);
            res.status(500).send(err.detail);
        } else {
            res.status(200).json({
                status: 'User created',
            });
        }
    })

})

app.get('/api/user/login', (req, res) => {
    console.log(req)
    // client.query(`select ${}`)
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
