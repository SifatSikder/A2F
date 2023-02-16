const mysql = require("mysql");
const pool = mysql.createPool({
  connectionLimit: 100,
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
}); // a cache of database connection so that we can reuse connections when future requests come in


module.exports = pool;