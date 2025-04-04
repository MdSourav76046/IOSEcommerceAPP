const express = require('express')
const router = express.Router()
const productController = require('../controllers/productController')
const { body, param } = require('express-validator')

const productValidator = [
    body('name', 'name can not be empty').not().isEmpty(),
    body('description', 'description can not be empty').not().isEmpty(),
    body('price', 'price can not be empty').not().isEmpty(),
    body('photo_url').not().isEmpty().withMessage('photo_url can not be empty') 
]

const deleteProductValidator = [
    param('productId')
    .notEmpty().withMessage('productId can not be empty')
    .isNumeric().withMessage('productId must be a number')
]


// api/products

router.get('/', productController.getAllProducts)
router.post('/', productValidator, productController.create)
router.get('/user/:userId', productController.getMyProducts)
router.post('/upload', productController.upload)
// Delete the product

router.delete('/:productId', deleteProductValidator, productController.deleteProduct)

module.exports = router