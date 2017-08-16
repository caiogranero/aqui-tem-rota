const db = require('../config/db')

const Database = {
  query (query) {
    return new Promise((resolve, reject) => {
      db.query(query, (err, result) => {
        if (err) reject(err)
        resolve(result)
      })

    })
  },
  insert (table, items) {
    return new Promise((resolve, reject) => {
      db.query(`INSERT INTO ${table} SET ?`, items, (err, result) => {
        if (err) reject(err)
        resolve(result.insertId)
      })
    })
  }
}

module.exports = Database
