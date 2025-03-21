const express = require('express')
const router = express.Router()
const productController = require('../controllers/productController')
const { body } = require('express-validator')

const productValidator = [
    body('name', 'name can not be empty').not().isEmpty(),
    body('description', 'description can not be empty').not().isEmpty(),
    body('price', 'price can not be empty').not().isEmpty(),
    body('photo_url').not().isEmpty().withMessage('photo_url can not be empty') 
]


// api/products

router.get('/', productController.getAllProducts)
router.post('/', productValidator, productController.create)
router.get('/user/:userId', productController.getMyProducts)
router.post('/upload', productController.upload)

module.exports = router