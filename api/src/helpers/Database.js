const db = require('../config/db')

const Database = {
  query (query) {
    return new Promise((resolve, reject) => {
      db.query(query, (err, result) => {
        if (err) reject(err)
        resolve(result)
      })
    })
  }
}

module.exports = Database
