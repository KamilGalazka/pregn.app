const express = require('express')
const navigationController = require('./../controllers/navigationController')

const router = express.Router()

router
    .route('/api/navigation')
    .get(navigationController.getNavigation)

module.exports = router