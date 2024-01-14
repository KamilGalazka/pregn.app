const express = require('express')
const articleController = require('./../controllers/articleController')

const router = express.Router()

router
    .route('/api/article/:type')
    .get(articleController.getAllArticles)

router
    .route('/api/article/:type/:id')
    .get(articleController.getArticle)

module.exports = router