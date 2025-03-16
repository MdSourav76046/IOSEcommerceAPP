const models = require('../models')
const { Op } = require('sequelize')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const { validationResult } = require('express-validator')
const user = require('../models/user')

exports.login = async (req, res) => {
    const errors = validationResult(req)

    if (!errors.isEmpty()) {
        const msg = errors.array().map(erros => erros.msg).join('')
        return res.status(422).json({ success: false, message: msg })
    }

    try{
        const {username, password} = req.body

        // Check if a user exists with the given username
        const existingUser = await models.User.findOne({
            where: {
                username: { [Op.iLike]: username }
            }
        })
        if(!existingUser){
            return res.status(404).json({ success: false, message: "Username or password is invalid" })
        }

        // Check for password match or not
        const isPasswordValid = await bcrypt.compare(password, existingUser.password)
        if(!isPasswordValid){
            return res.status(404).json({ success: false, message: "Username or password is invalid" })
        }

        // generate the JWT token
        const token = jwt.sign({ userId: existingUser.id}, 'SECRETKEY', {
            expiresIn: '1h'
        })

        return res.status(200).json({ success: true, userId: existingUser.id, token: token, username: existingUser.username })
        
    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal server error!" })
    }
}


exports.register = async (req, res) => {

    const errors = validationResult(req)

    if (!errors.isEmpty()) {
        const msg = errors.array().map(erros => erros.msg).join('')
        return res.status(422).json({ success: false, message: msg })
    }

    try {
        const { username, password } = req.body
        const existingUser = await models.User.findOne({
            where: {
                username: { [Op.iLike]: username }
            }
        })

        if (existingUser) {
            return res.status(409).json({ success: false, message: "User already exists" })
        }

        // create a password hash
        const salt = await bcrypt.genSalt(10)
        const hashedPassword = await bcrypt.hash(password, salt)

        // create a new user in the database
        const newUser = await models.User.create({
            username: username,
            password: hashedPassword
        })
        res.status(201).json({ success: true, message: "User created successfully" })
    } catch (err) {
        res.status(500).json({ success: false, message: 'Internal Server Error' })
    }
}