const models = require('../models')

exports.addCartItem = async (req, res) => {
    const { productId, quantity } = req.body
    req.userId = 21 // It is hard Coded
    try{
        let cart = await models.Cart.findOne({
            where: {
                user_id: req.userId,
                is_active: true
            }
        })

        if(!cart){
            cart = await models.Cart.create({
                user_id: req.userId,
                is_active: true
            })
        }
        // get cartItem with Product
        const cartItemWithProduct  = await models.CartItem.findOne({
            where: {
                cart_id: cart.id,
            },
            attributes: ['id', 'cart_id', 'product_id', 'quantity'],
            include: {
                model: models.Product,
                as: 'product',
                attributes: ['id', 'name', 'description', 'price', 'photo_url', 'user_id']
            }
        })


        const [cartItem, created] = await models.CartItem.findOrCreate({
            where: {
                cart_id: cart.id,
                product_id: productId
            },
            defaults: {quantity}
        })
        console.log(cartItem)

        if(!created){
            cartItem.quantity += quantity
            await cartItem.save()
        }
        res.status(201).json({ 
            success: true, 
            message: "Item Added to the cart",
            cartItem: cartItemWithProduct
        })

    }catch(error){
        res.status(500).json({ success: false, message: "Internal Server Error" })
    }
}