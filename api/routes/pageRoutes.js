const express = require('express')
const pageController = require('./../controllers/pageController')

const router = express.Router()

router
    .route('/api/page/:name')
    .get(pageController.getPage)

module.exports = router