const express = require('express')
const router = express.Router()
const cartController = require('../controllers/cartController')

router.post('/items', cartController.addCartItem)


module.exports = router