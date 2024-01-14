const express = require('express')
const stageController = require('./../controllers/stageController')

const router = express.Router()

router
    .route('/api/stage/:week')
    .get(stageController.getStage)

module.exports = router