const {client} = require('../services/dbService')
const {errorHandling} = require("../utils/helpers");

const getAllArticles = async (req, res) => {
    const categoryType = req.params.type
    let queryResult

    try {
        queryResult = await client.query(`select id,
                                                 title_pl,
                                                 title_en,
                                                 description_pl,
                                                 description_en,
                                                 image_name,
                                                 published,
                                                 published_date
                                          from article
                                          where article.category = '${categoryType}'`)
    } catch (error) {
        errorHandling('getAllArticles', '/api/article/:type', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows,
    })
}

const getArticle = async (req, res) => {
    const {id, type: categoryType} = req.params
    let queryResult

    try {
        queryResult = await client.query(`select *
                                          from article
                                          where article.category = '${categoryType}'
                                            and article.id = ${id}`)
    } catch (error) {
        errorHandling('getArticle', '/api/article/:type/:id', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows[0],
    })
}

module.exports = {
    getAllArticles,
    getArticle,
}