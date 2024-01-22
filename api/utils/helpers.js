const bcrypt = require("bcrypt");
const hashPassword = async (password) => {
    const saltRounds = 10
    let bcryptResult

    try {
        bcryptResult = await bcrypt.hash(password, saltRounds)
    } catch (error) {
        console.log('bcrypt error', error)
    }

    return bcryptResult
}

const comparePasswords = async (password, hashedPassword) => {
    let bcryptResult

    try {
        bcryptResult = await bcrypt.compare(password, hashedPassword)
    } catch (error) {
        console.log('/api/user/login bcrypt error', error)
    }

    return bcryptResult
}

const errorHandling = (methodName, endpointName, error) => {
    console.log('error', methodName, endpointName, error)
}

const validateUserName = (name) => {
    return !!name
}

const validateUserLastname = (lastname) => {
    return !!lastname
}

const validateUserEmail = (email) => {
    return /^\S+@\S+\.\S+$/.test(email)
}

const validateUserPassword = (password) => {
    const passwordMinLength = 6

    if (!password) return false

    return password.length >= passwordMinLength
}

module.exports = {
    hashPassword,
    comparePasswords,
    errorHandling,
    validateUserName,
    validateUserLastname,
    validateUserEmail,
    validateUserPassword,
}