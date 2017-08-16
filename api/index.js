const app = require('./config/server')
const port = process.env.PORT || 3000

app.get('*', (req, res) => {
  res.status(404).send({error: '404 not found'})
})

app.listen(port, () => {
  console.log(`Server listen on port ${port}`)
})

