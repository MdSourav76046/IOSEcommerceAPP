const express = require('express')
const cors = require('cors')
const app = express()

const authRoutes = require('./routes/auth')
const productRoutes = require('./routes/product')

// make static folder uploads
app.use('/api/uploads', express.static('uploads'))

// Using CORS

app.use(cors())
// JSON Parser
app.use(express.json())

// Register Our Routers
app.use('/api/auth', authRoutes)
app.use('/api/products', productRoutes)



// Starting the server
app.listen(8080, () => {
    console.log("The server is running!")
})