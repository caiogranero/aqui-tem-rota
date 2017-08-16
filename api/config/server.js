const express = require('express')
const consign = require('consign');
const bodyParser = require('body-parser')
const helmet = require('helmet')
const cookieParser = require('cookie-parser')
const app = express()

app.use(cookieParser())
app.use(helmet())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

consign()
    .include('./routes')
    .into(app);

module.exports = app;
