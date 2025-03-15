const express = require('express')
const models = require('./models')
const { Op } = require('sequelize')
const cors = require('cors')
const { body, validationResult } = require('express-validator')
const app = express()
const bcrypt = require('bcrypt')
// Using CORS

app.use(cors())
// JSON Parser
app.use(express.json())

const registerValidator = [
    body('username', 'username can not be empty').not().isEmpty(),
    body('password', 'password can not be empty').not().isEmpty()
]
// Routing
app.post('/api/auth/register', registerValidator, async (req, res) => {

    const errors = validationResult(req)
    console.log(errors)
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
})

// app.get('/register', (req, res) => {
//     res.send("Hello There Keya Moni!")
// })



// Starting the server
app.listen(8080, () => {
    console.log("The server is running!")
})