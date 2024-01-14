const {client} = require('../services/dbService')

const addNewNoteToCalendar = async (req, res) => {
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
}

const getAllUserNotes = async (req, res) => {
    let queryResult

    const {id: userId} = res.locals.tokenData

    try {
        queryResult = await client.query(`select id, title, content, priority, date
                                          from calendar
                                          where user_id = ${userId}`)
    } catch (error) {
        console.log('/api/calendar get data error', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows,
    })
}

const changeNote = async (req, res) => {
    let queryResult
    const {noteId, title, content, priority, date} = req.body

    try {
        queryResult = await client.query(`update calendar
                                          set (title, content, priority, date) = ('${title}', '${content}', ${priority}, '${date}')
                                          where id = ${noteId} returning *`)
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
}

const deleteNote = async (req, res) => {
    const {noteId} = req.body

    try {
        await client.query(`delete
                            from calendar
                            where id = ${noteId}`)
    } catch (error) {
        console.log('/api/calendar/delete data error', error)

        return res.status(404).json({
            status: "NOK note not deleted",
        })
    }

    res.status(200).json({
        status: 'OK',
    })
}

module.exports = {
    addNewNoteToCalendar,
    getAllUserNotes,
    changeNote,
    deleteNote,
}