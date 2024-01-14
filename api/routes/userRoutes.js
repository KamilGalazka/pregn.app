const express = require('express')
const userController = require('./../controllers/userController')
const {verifyToken} = require('../middlewares/verifyTokenMiddleware')
const {verifyPassword} = require('../middlewares/verifyPasswordMiddleware')

const router = express.Router()

router
    .route('/api/user/create')
    .post(userController.createNewAccount)

router
    .route('/api/user/info')
    .get(verifyToken, userController.getUserInformation)

router
    .route('/api/user/change/data')
    .patch(verifyToken, userController.changeUserData)

router
    .route('/api/user/change/password')
    .patch(verifyToken, verifyPassword, userController.changeUserPassword)

router
    .route('/api/user/delete')
    .delete(verifyToken, userController.deleteUserAccount)

router
    .route('/api/user/login')
    .post(userController.loginToAccount)

router
    .route('/api/user/create')
    .post(userController.refreshUserToken)

module.exports = router