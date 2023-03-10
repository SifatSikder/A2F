const express = require( 'express' );
const router = express.Router();
const SSLCommerzPayment = require( "sslcommerz" );
const User = require( '../models/user' );
const crypto = require( 'crypto' );


router.get( '/charge', ( req, res ) =>{
  User.findById( req.user._id, ( err, user ) => { res.render( 'payments/recharge', { user } ); } )
})

router.post( '/charge',  async ( req, res ) =>
{

  const id = crypto.randomBytes( 16 ).toString( "hex" );
  const { amount } = req.body;
  const user = await User.findById( req.user._id )
  const data = {
    //transaction info
    total_amount: amount,
    currency: 'BDT',
    tran_id: id,
    cus_name: user.username,
    cus_email: user.email,
    cus_phone: user.PhoneNumber,

    //redirection urls
    success_url: `https://localhost:8000/payment/ssl-payment-success`,
    fail_url: `https://localhost:8000/payment/ssl-payment-fail`,
    cancel_url: `https://localhost:8000/payment/ssl-payment-cancel`,
    ipn_url: `https://localhost:8000/payment/ssl-payment-notification`,


    //will not be needed for our A2F but if we delete it sslcommerz will not work
    shipping_method: 'No',
    product_name: 'Computer.',
    product_category: 'Electronic',
    product_profile: 'general',
  };
  const sslcommerz = new SSLCommerzPayment( process.env.STORE_ID, process.env.STORE_PASSWORD, false ) //true for live default false for sandbox
  sslcommerz.init( data ).then( data =>
  {
    if ( data.GatewayPageURL )
    {
      // process.env.NODE_ENV='production'
      // req.session.cookie.secure=true
      return res.status( 200 ).redirect( data.GatewayPageURL );
    }
    else
    {
      return res.status( 400 ).json( {
        message: "Session was not successful"
      } );
    }
  } );
} );

router.post("/ssl-payment-notification", async (req, res) => {

  return res.status(200).json(
    {
      data: req.body,
      message: 'Payment notification'
    }
  );
})

router.post("/ssl-payment-success",isLoggedIn , async (req, res) => {

  const user = await User.findById( req.user._id )
  user.wallet += Number(req.body.store_amount);
  user.save();
  return res.redirect( '/user/dashboard' );
})

router.post("/ssl-payment-fail", async (req, res) => {

  return res.status(200).json(
    {
      data: req.body,
      message: 'Payment failed'
    }
  );
})

router.post("/ssl-payment-cancel", async (req, res) => {

  return res.status(200).json(
    {
      data: req.body,
      message: 'Payment cancelled'
    }
  );
})

function isLoggedIn( req, res, next )
{
  
  // console.log("req.headers: ")
  // console.log(req.headers)
  // console.log("req.session");
  // console.log(req.session);
  console.log("res");
  console.log(res);
  if ( req.isAuthenticated() )
  {
    return next();
  }
  res.redirect( '/user/login' );
}

module.exports = router;