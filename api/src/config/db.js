const pg = require('pg')

const connectionString = {
  user: 'postgres',
  host: 'localhost',
  database: 'aqui_tem_rota',
  password: '123',
  port: 5432
}

const connection = new pg.Client(connectionString)
connection.connect()

module.exports = connection
