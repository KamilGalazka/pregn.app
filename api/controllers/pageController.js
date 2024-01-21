const {client} = require('../services/dbService')
const {errorHandling} = require("../utils/helpers");

const getPage = async (req, res) => {
    const pageName = req.params.name
    let queryResult

    try {
        queryResult = await client.query(`select *
                                          from pages
                                          where name = '${pageName}'`)
    } catch (error) {
        errorHandling('getPage', '/api/page/:name', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows[0],
    })
}

module.exports = {
    getPage,
}