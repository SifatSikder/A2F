//App creation
const express = require("express");
const app = express();

//port setup
require('dotenv').config()
const port = process.env.PORT || 8080;

//logger configuration
const morgan = require('morgan');
if (process.env.NODE_ENV == 'development') { app.use(morgan('dev')); }

//cors setup
const cors = require("cors");
app.use(cors())

//database connection
const connectDB = require('./config/db')
connectDB();

//passport configuration
const passport = require('passport');
app.use(passport.initialize());
// app.use(passport.session());


//body parser configutation
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

//system Wallet creation
require('./config/systemWalletCreation')

//router configuration
const userRoutes = require('./routes/user');
app.use('/user', userRoutes);

const adminRoutes = require('./routes/admin');
app.use('/admin', adminRoutes);

const loanRoutes = require('./routes/loan');
app.use('/loan', loanRoutes);


//server listens here
app.listen(port, () => { console.log(`server is runing on ${process.env.NODE_ENV} mode at port ${port}`) }) 