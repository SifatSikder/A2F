const express = require("express");
const app = express();
const exphbs = require("express-handlebars");
const body_parser = require("body-parser");
require("dotenv").config(); // we can have a central place for database credentials
const port = process.env.PORT || 8000;

app.use(body_parser.urlencoded({ extended: false }));
app.use(body_parser.json());
app.use(express.static("public"));
app.engine("hbs", exphbs.engine({ extname: ".hbs" }));
app.set("view engine", "hbs");

const user= require("./server/routes/authentication")
app.use("",user);


app.listen(port, () => {console.log(`Listening on port ${port}`);});
