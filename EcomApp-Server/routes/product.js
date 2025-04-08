const express = require('express')
const router = express.Router()
const productController = require('../controllers/productController')
const { body, param } = require('express-validator')
const authenticate = require('../middlewares/authMiddleware')

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

const updateProductValidator = [
    param('productId')
    .notEmpty().withMessage('productId can not be empty')
    .isNumeric().withMessage('productId must be a number'),
    body('name', 'name can not be empty').not().isEmpty(),
    body('description', 'description can not be empty').not().isEmpty(),
    body('price', 'price can not be empty').not().isEmpty(),
    body('photo_url').not().isEmpty().withMessage('photo_url can not be empty'),
    body('user_id')
    .notEmpty().withMessage('user_id can not be empty')
    .isNumeric().withMessage('user_id must be a number'),
]


// api/products
router.get('/', productController.getAllProducts)
router.post('/',authenticate, productValidator, productController.create)
router.get('/user/:userId', authenticate, productController.getMyProducts)
router.post('/upload',authenticate, productController.upload)
// Delete the product
router.delete('/:productId', authenticate, deleteProductValidator, productController.deleteProduct)

// For updating the product
router.put('/:productId',authenticate, updateProductValidator, productController.updateProduct)

module.exports = router