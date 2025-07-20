const express = require('express')
const router = express.Router()
const cartController = require('../controllers/cartController')
const cart = require('../models/cart.js')

//add Cart Item
router.post('/items', cartController.addCartItem)

// Load cart Item
router.get('/', cartController.loadCart)

// Delete the cart Item
router.delete('/item/:cartItemId', cartController.removeCartItem)

module.exports = router