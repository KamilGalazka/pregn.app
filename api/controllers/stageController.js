const {client} = require('../services/dbService')
const {errorHandling} = require("../utils/helpers");

const getStage = async (req, res) => {
    const week = req.params.week
    let queryResult

    try {
        queryResult = await client.query(`select *
                                          from pregnancy_stages
                                          where week = ${week}`)
    } catch (error) {
        errorHandling('getStage', 'api/stage/:week', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows[0],
    })
}

module.exports = {
    getStage,
}