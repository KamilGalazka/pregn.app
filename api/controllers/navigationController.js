const {client} = require('../services/dbService')
const {errorHandling} = require("../utils/helpers");

const getNavigation = async (req, res) => {
    let queryResult

    try {
        queryResult = await client.query('select * from navigation')
    } catch (error) {
        errorHandling('getNavigation', '/api/navigation', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows,
    })
}

module.exports = {
    getNavigation,
}