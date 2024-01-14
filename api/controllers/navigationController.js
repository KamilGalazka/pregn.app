const {client} = require('../services/dbService')

const getNavigation = async (req, res) => {
    let queryResult

    try {
        queryResult = await client.query('select * from navigation')
    } catch (error) {
        console.log('/api/navigation error', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows,
    })
}

module.exports = {
    getNavigation,
}