const https = require("https");
const fs = require("fs");



//App creation
const express = require("express");
const app = express();

//port setup
require('dotenv').config();
const port = process.env.PORT || 8080;
const cors = require("cors");
app.use(cors())


//database connection
const mongoose = require('mongoose');
mongoose.connect(process.env.DATABASE_URL,{ useNewUrlParser: true} ,function(err) {
    if (err) {
        console.log("Database Not Connected", err);
    } else {
        console.log("Database Connected")
    }
});
mongoose.set('useFindAndModify', false);

//body parser configutation
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended: false}));

//Other usage for application
app.use(express.static("public"));
app.set('view engine','ejs');
// const cookieParser = require('cookie-parser')
// app.use(cookieParser(process.env.SESSION_SECRET));
const session =require('express-session')
const MongoStore = require("connect-mongo");

app.set('trust proxy', 1)
app.use(session({
    secret: process.env.SESSION_SECRET,
    // cookie : { maxAge: 24 * 60 * 60 * 1000, secure: true,httpOnly : false },
    resave: false,
    saveUninitialized: true,
    store: MongoStore.create({mongoUrl: process.env.DATABASE_URL, collectionName: "sessions",})
}));

//caching configuration
app.use((req,res,next) => {
    res.set('Cache-Control','no-cache, private, no-store, must revalidate, max-stale=0, post-check=0, pre-check=0')
    res.locals.currentUser = req.user;
    next();
});


// //morgan configuration
const morgan = require('morgan');
app.use(morgan('dev'));


//passport configuration
const passport = require('passport');
app.use(passport.initialize());
app.use(passport.session());


app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  })


//router configuration
const userRoutes = require('./routes/user');
app.use('/user',userRoutes);
const loanRoutes = require('./routes/loan');
app.use('/loan',loanRoutes);
const adminRoutes = require('./routes/admin');
app.use('/admin',adminRoutes);
const agentRoutes = require('./routes/agent');
app.use('/agent',agentRoutes);
const paymentRoutes = require('./routes/payment');
app.use('/payment',paymentRoutes);




//Home page
app.get('/',(req,res)=>{res.render('home');})

//Server Start
https.createServer({
    key: fs.readFileSync("key.pem"),
    cert: fs.readFileSync("cert.pem"),
  },app).listen(port, ()=>{console.log(`server is runing at port ${port}`)});