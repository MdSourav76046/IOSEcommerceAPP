const express = require('express')
const router = express.Router()
const {body} = require('express-validator')

const authController = require('../controllers/authController')

const registerValidator = [
    body('username', 'username can not be empty').not().isEmpty(),
    body('password', 'password can not be empty').not().isEmpty()
]

const loginValidator = [
    body('username', 'username can not be empty').not().isEmpty(),
    body('password', 'password can not be empty').not().isEmpty()
]


router.post('/register', registerValidator, authController.register)  
router.post('/login', authController.login, authController.login)

module.exports = router
