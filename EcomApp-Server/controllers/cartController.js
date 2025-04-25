exports.addCartItem = async (req, res) => {
    try {
        const {cart_id, product_id, quantity} = req.body
        const cartItem = await models.CartItem.create({
            cart_id,
            product_id,
            quantity
        })
        return res.json(cartItem)
    } catch (error) {
        return res.status(500).json({ success: false, message: "Internal Server Error" })
    }
}