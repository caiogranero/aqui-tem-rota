const express = require('express')
const consign = require('consign')
const bodyParser = require('body-parser')
const helmet = require('helmet')
const cookieParser = require('cookie-parser')
const app = express()
const cors = require('cors')
const path = require('path')
const __static = path.join(__dirname, '/../static/')

app.use(cookieParser())
app.use(helmet())
app.use(cors())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use('/', express.static(__static))

consign()
    .include('./routes')
    .into(app)

module.exports = app
