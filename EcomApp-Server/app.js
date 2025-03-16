const express = require('express')
const cors = require('cors')
const app = express()

const authRoutes = require('./routes/auth')


// Using CORS

app.use(cors())
// JSON Parser
app.use(express.json())

// Register Our Routers

app.use('/api/auth', authRoutes)



// Starting the server
app.listen(8080, () => {
    console.log("The server is running!")
})