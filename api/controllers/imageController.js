const {client} = require('../services/dbService')
const {errorHandling} = require("../utils/helpers");
const {dirname} = require('path');
const {readFile, unlinkSync} = require("fs");

const addNewImage = async (req, res) => {
    const {id: userId} = res.locals.tokenData
    const {filename} = req.file;

    try {
        await client.query(`insert into user_images (user_id, name)
                            values (${userId}, '${filename}');`)
    } catch (error) {
        errorHandling('addNewImage', '/api/user/image', error)

        return res.status(404).json({
            status: "NOK image not added",
        })
    }

    res.status(201).json({
        status: 'OK',
    })
}

const getAllImages = async (req, res) => {
    let queryResult
    const {id: userId} = res.locals.tokenData

    try {
        queryResult = await client.query(`select name
                                          from user_images
                                          where user_id = ${userId}`)
    } catch (error) {
        errorHandling('getAllImages', '/api/user/image', error)
    }

    res.status(200).json({
        status: 'OK',
        response: queryResult.rows,
    })
}

const getImage = async (req, res) => {
    const {id: userId} = res.locals.tokenData
    const appDir = dirname(require.main.filename);
    const {name} = req.params

    readFile(`${appDir}/bucket/images/${userId}/${name}`, function (err, data) {
        if (!data) {
            return res.status(404).json({
                status: "NOK image don't exist",
            })
        }

        let base64 = Buffer.from(data).toString('base64');
        base64 = 'data:image/png;base64,' + base64;
        return res.send(base64);
    })
}

const deleteImage = async (req, res) => {
    const {id: userId} = res.locals.tokenData
    const appDir = dirname(require.main.filename);
    const {name} = req.params

    try {
        await client.query(`delete
                            from user_images
                            where user_id = ${userId}
                              and name = '${name}'`)
    } catch (error) {
        errorHandling('deleteImage', '/api/user/image/:name', error)

        return res.status(404).json({
            status: "NOK image not deleted from DB",
        })
    }

    try {
        unlinkSync(`${appDir}/bucket/images/${userId}/${name}`)
    } catch (error) {
        errorHandling('deleteImage', '/api/user/image/:name', error)

        return res.status(404).json({
            status: "NOK image not deleted from files",
        })
    }

    res.status(200).json({
        status: 'OK',
    })
}

module.exports = {
    addNewImage,
    getAllImages,
    getImage,
    deleteImage,
}