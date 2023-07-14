const express = require('express')
const cors = require('cors');

const app = express()
const port = 3000

app.use(cors({origin: '*'}));

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
                name: "Zaloguj się",
                path: "/path3",
            },
        ],
    })
})
app.listen(port, () => {
    console.log('test')
})