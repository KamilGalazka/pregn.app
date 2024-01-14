const express = require('express')
const calendarController = require('./../controllers/calendarController')
const {verifyToken} = require('../middlewares/verifyTokenMiddleware')

const router = express.Router()

router
    .route('/api/calendar/add')
    .post(verifyToken, calendarController.addNewNoteToCalendar)

router
    .route('/api/calendar/get')
    .get(verifyToken, calendarController.getAllUserNotes)

router
    .route('/api/calendar/change')
    .put(verifyToken, calendarController.changeNote)

router
    .route('/api/calendar/delete')
    .delete(verifyToken, calendarController.deleteNote)

module.exports = router