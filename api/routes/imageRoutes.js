const express = require('express')
const multer = require('multer')
const imageController = require('./../controllers/imageController')
const {verifyToken} = require("../middlewares/verifyTokenMiddleware");
const {mkdirSync} = require("fs");

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const {id: userId} = req.res.locals.tokenData
        const path = `./bucket/images/${userId}/`

        mkdirSync(path, {recursive: true})
        cb(null, path);
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + '-' + file.originalname);
    }
});
const upload = multer({ storage: storage });
const router = express.Router()

router
    .route('/api/user/image')
    .post(verifyToken, upload.single('image'), imageController.addNewImage)
    .get(verifyToken, imageController.getAllImages)

router
    .route('/api/user/image/:name')
    .get(verifyToken, imageController.getImage)
    .delete(verifyToken, imageController.deleteImage)

module.exports = router