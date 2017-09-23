const app = require('./config/server')
const port = process.env.PORT || 3000
const path = require('path')
const __static = path.join(__dirname, '/../static/')

app.get('/', (req, res) => {
  res.sendFile(path.join(__static, 'index.html'))
})

app.get('*', (req, res) => {
  res.status(404).send({error: '404 not found'})
})

app.listen(port, () => {
  console.log(`Server listen on port ${port}`)
})
