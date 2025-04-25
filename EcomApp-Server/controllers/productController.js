const models = require('../models')
const { validationResult } = require('express-validator')
const multer = require('multer')
const path = require('path')
const { getFileNameFromUrl } = require('../Utils/fileUtils')
const {deleteFile} = require('../Utils/fileUtils')
// setup the storage for uploading the files with multer
// configuring multer for file storage
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/')
    },
    filename: function (req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname))
    }
})

// setting up multer for image upload
const uploadImage = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 5
    },
    fileFilter: function (req, file, cb) {
        const filetypes = /jpeg|jpg|png/
        const extname = filetypes.test(path.extname(file.originalname).toLowerCase())
        const mimetype = filetypes.test(file.mimetype)

        if (mimetype && extname) {
            return cb(null, true)
        } else {
            cb(new Error('Only Images are allowed!'))
        }
    }
}).single('image')


exports.upload = (req, res) => {
    uploadImage(req, res, (err) => {
        if (err) {
            return res.status(400).json({ success: false, message: err.message })
        }

        if (!req.file) {
            return res.status(400).json({ success: false, message: "No file uploaded" })
        }
        const baseUrl = `${req.protocol}://${req.get('host')}`
        const filePath = `api/uploads/${req.file.filename}`
        const downloadUrl = `${baseUrl}/${filePath}`
        res.json({ message: "File uploaded successfully", downloadUrl: downloadUrl, success: true })
    })
}


// getting only one user output
exports.getMyProducts = async (req, res) => {
    try {
        const userId = req.params.userId
        const products = await models.Product.findAll({
            where: {
                user_id: userId
            }
        })
        return res.json(products)
    } catch (error) {
        return res.status(500).json({ success: false, message: "Internal Server Error" })
    }
}

// getting all the product
exports.getAllProducts = async (req, res) => {
    const products = await models.Product.findAll({})
    res.json(products)
}

// api/products/user/6
exports.create = async (req, res) => {
    const errors = validationResult(req)

    if (!errors.isEmpty()) {
        const msg = errors.array().map(erros => erros.msg).join('')
        return res.status(422).json({ success: false, message: msg })
    }
    console.log("HI")
    const { name, description, price, photo_url, user_id } = req.body

    try {
        const newProduct = await models.Product.create({
            name: name,
            description: description,
            price: price,
            photo_url: photo_url,
            user_id: user_id
        })
        res.status(201).json({ success: true, product: newProduct })
    } catch (error) {
        res.status(500).json({ success: false, message: "Internal Server Error" })
    }
}

// Api to delete the product
exports.deleteProduct = async (req, res) => {

    const errors = validationResult(req)

    if (!errors.isEmpty()) {
        const msg = errors.array().map(erros => erros.msg).join('')
        return res.status(422).json({ success: false, message: msg })
    }

    const productId = req.params.productId
    try {
        const product = await models.Product.findByPk(productId)
        if (!product) {
            return res.status(404).json({ success: false, message: "Product not found" })
        }

        const fileName = getFileNameFromUrl(product.photo_url)

        const result = await models.Product.destroy(
            { 
                where: { 
                    id: productId 
                } 
            }
        )
        console.log(result)
        console.log(fileName)
        if(result === 0){
            return res.status(404).json({ success: false, message: "Product not found" })
        }

        try {
            await deleteFile(fileName)
            console.log("File deletion completed")
        } catch (fileError) {
            console.error("Error during file deletion:", fileError)
            // Continue with response even if file deletion fails
        }

        res.json({ success: true, message: "Product with ID " + productId + " has been deleted" })
    } catch (error) {
        res.status(500).json({ success: false, message: "Error deleting product with ID " + error.message })
    }
}


exports.updateProduct = async (req, res) => {

    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        const msg = errors.array().map(error => error.msg).join('')
        return res.status(422).json({ message: msg, success: false });
    }

    try {
        const { name, description, price, photo_url, user_id } = req.body
        const { productId } = req.params 

        const product = await models.Product.findOne({
            where: {
                id: productId, 
                user_id: user_id
            }
        })

        console.log(product)

        if(!product) {
            return res.status(404).json({ message: 'Product not found', success: false });
        }

        // update the product 
        await product.update({
            name, 
            description, 
            price, 
            photo_url
        })

        return res.status(200).json({
            message: 'Product updated successfully', 
            success: true, 
            product 
        })


    } catch (err) {
        return res.status(500).json({
            message: 'An error occurred while updating the product',
            success: false
          });
    }

}
