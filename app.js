const express = require("express");
const app = express();
const exphbs = require("express-handlebars");
const body_parser = require("body-parser");
const mysql = require("mysql");
require("dotenv").config(); // we can have a central place for database credentials
const port = process.env.PORT || 8000;

app.use(body_parser.urlencoded({ extended: false }));
app.use(body_parser.json());
app.use(express.static("public"));

app.engine("hbs", exphbs.engine({ extname: ".hbs" }));
app.set("view engine", "hbs");

const pool = mysql.createPool({
  connectionLimit: 100,
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
}); // a cache of database connection so that we can reuse connections when future requests come in

pool.getConnection((err, connection) => {
    if (err) throw err;
    console.log(`Connected to database as ID ${connection.threadId}`);
})//connecting to the database

app.get("", (req, res) => {
  res.render("home");
});

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
