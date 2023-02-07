const express = require('express');
const app= express();
const exphbs= require('express-handlebars');
const body_parser = require('body-parser');
const mysql = require('mysql');
require('dotenv').config();
const port= process.env.PORT || 8000;

app.use(body_parser.urlencoded({extended: false}))
app.use(body_parser.json())
app.use(express.static('public'))

app.engine('hbs', exphbs.engine({extname: '.hbs'}));
app.set('view engine', 'hbs');

app.get('', (req,res)=>{res.render('home')})



app.listen(port, ()=>{console.log(`Listening on port ${port}`);})


