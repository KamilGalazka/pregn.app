const {Client} = require("pg");
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

async function connectToDatabase() {
    client.connect()
        .then(() => console.log('Connected to database'))
        .catch(err => console.error('Connection to database failed:', err))
}

module.exports = {
    connectToDatabase,
    client,
}