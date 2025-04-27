const jwt = require("jsonwebtoken")
const models = require("../models")

// I want to authenticate a user based on webtoken

const authenticate = async (req, res, next) => {
    // get the authorization header
    const authHeader = req.headers.authorization
    if (!authHeader) {
        return res.status(401).json({ success: false, message: "No token Provided" })
    }
    const token = authHeader.split(" ")[1]
    if(!token){
        return res.status(401).json({ success: false, message: "Invalid input token" })
    }
    try {
        // Verify the token
        const decoded = jwt.verify(token, "SECRETKEY")
        const user = await models.User.findByPk(decoded.userId)
        if (!user) {
            return res.status(401).json({ success: false, message: "Unauthorize User" })
        }
        req.user = user.id 
        next()
    } catch (error) {
        return res.status(401).json({ success: false, message: "Error Authorization" })
    }
}
module.exports = authenticate    
