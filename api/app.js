const dotenv = require('dotenv')
const express = require('express')
const cors = require('cors')
const bodyParser = require('body-parser')
const cookieParser = require("cookie-parser")

const {connectToDatabase} = require('./services/dbService')

const articleRouter = require('./routes/articleRoutes')
const calendarRouter = require('./routes/calendarRoutes')
const navigationRouter = require('./routes/navigationRoutes')
const stageRouter = require('./routes/stageRoutes')
const userRoutes = require('./routes/userRoutes')

dotenv.config()
const app = express()
const port = process.env.PORT || 3000

connectToDatabase()

app.use(cors({origin: '*'}))
app.use(cookieParser())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

app.use(articleRouter)
app.use(calendarRouter)
app.use(navigationRouter)
app.use(stageRouter)
app.use(userRoutes)

process.on('exit', () => {
    client.end()
})

app.listen(port, () => {
    console.log('Server started...')
})
