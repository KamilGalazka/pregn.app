const express = require('express')
const cors = require('cors');

const app = express()
const port = 3000

app.use(cors({origin: '*'}));

app.get('/api/test', (req, res) => {
    res.status(200).json( {
        status: 'OK',
        response: {
            data: 'Test'
        }
    })
})
app.listen(port, () => {
    console.log('test')
})