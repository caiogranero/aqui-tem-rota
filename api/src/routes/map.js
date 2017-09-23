const Map = require('../models/Map')

module.exports = (app) => {
  app.get('/api/map', (req, res) => {
    if (req.body) {
      Map.get(req.query).then(results => {
        res.status(200).send({ error: false, message: '', results })
      })
      .catch(err => {
        res.status(500).send({ error: true, message: err.toString() })
      })
    } else {
      res.status(400).send({ error: true, message: 'Missing body content' })
    }
  })
}
