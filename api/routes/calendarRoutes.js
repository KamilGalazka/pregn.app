const express = require('express')
const calendarController = require('./../controllers/calendarController')
const {verifyToken} = require('../middlewares/verifyTokenMiddleware')

const router = express.Router()

router
    .route('/api/calendar')
    .post(verifyToken, calendarController.addNewNoteToCalendar)
    .get(verifyToken, calendarController.getAllUserNotes)
    .put(verifyToken, calendarController.changeNote)
    .delete(verifyToken, calendarController.deleteNote)

module.exports = router