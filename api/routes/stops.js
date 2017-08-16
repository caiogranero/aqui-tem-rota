const Stops = require('../models/Stops')

module.exports = function(app){
  app.get('/api/stops', (req, res) => {
    if (req.body) {
      Stops.getAll(req.query).then(results => {
        res.status(200).send({error: false, message: '', results })
      })
      .catch(err => {
        res.status(200).send({error: true, message: err.toString() })
      })
    } else {
      res.status(200).send({error: true, message: 'Missing body content'})
    }
  })
}