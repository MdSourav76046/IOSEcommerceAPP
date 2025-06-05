const express = require('express')
const router = express.Router()
const cartController = require('../controllers/cartController')
const cart = require('../models/cart.js')

router.post('/items', cartController.addCartItem)

// Load cart
router.get('/', cartController.loadCart)

module.exports = router