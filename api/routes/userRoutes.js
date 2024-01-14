const express = require('express')
const userController = require('./../controllers/userController')
const {verifyToken} = require('../middlewares/verifyTokenMiddleware')
const {verifyPassword} = require('../middlewares/verifyPasswordMiddleware')

const router = express.Router()

router
    .route('/api/user')
    .post(userController.createNewAccount)
    .get(verifyToken, userController.getUserInformation)
    .delete(verifyToken, userController.deleteUserAccount)

router
    .route('/api/user/change/data')
    .patch(verifyToken, userController.changeUserData)

router
    .route('/api/user/change/password')
    .patch(verifyToken, verifyPassword, userController.changeUserPassword)

router
    .route('/api/user/login')
    .post(userController.loginToAccount)

router
    .route('/api/user/refresh')
    .post(userController.refreshUserToken)

module.exports = router