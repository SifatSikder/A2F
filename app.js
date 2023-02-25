const express = require("express");
const app = express();
const exphbs = require("express-handlebars");
const body_parser = require("body-parser");
const cookieParser = require("cookie-parser");
const cors = require("cors");


require("dotenv").config();
const port = process.env.PORT || 8000;

app.use(body_parser.urlencoded({ extended: false }));
app.use(express.json());
app.use(cookieParser());
app.use(cors());
app.use(express.static("public"));
app.engine("hbs", exphbs.engine({ extname: ".hbs" }));
app.set("view engine", "hbs");

const authentication= require("./server/routes/authentication")
app.use("",authentication);

const transaction= require("./server/routes/transaction")
app.use("",transaction);

app.listen(port, () => {console.log(`Listening on port ${port}`);});
