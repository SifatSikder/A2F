const pool = require("../../model/connection");
const SSLCommerzPayment = require("sslcommerz-lts");


exports.cashin = async (req, res) => {
  const {amount} = req.body;



};

exports.get_cashin3 = (req, res) => {
  const data = {
    total_amount: 500,
    currency: 'BDT',
    tran_id: 'REF123',
    success_url: `${process.env.ROOT}/ssl-payment-success`,
    fail_url: `${process.env.ROOT}/ssl-payment-fail`,
    cancel_url: `${process.env.ROOT}/ssl-payment-cancel`,
    shipping_method: 'No',
    product_name: 'Computer.',
    product_category: 'Electronic',
    product_profile: 'general',
    cus_name: 'Customer Name',
    cus_email: 'cust@yahoo.com',
    cus_add1: 'Dhaka',
    cus_add2: 'Dhaka',
    cus_city: 'Dhaka',
    cus_state: 'Dhaka',
    cus_postcode: '1000',
    cus_country: 'Bangladesh',
    cus_phone: '01711111111',
    cus_fax: '01711111111',
    multi_card_name: 'mastercard',
    value_a: 'ref001_A',
    value_b: 'ref002_B',
    value_c: 'ref003_C',
    value_d: 'ref004_D',
    ipn_url: `${process.env.ROOT}/ssl-payment-notification`,
  };
  const sslcommer = new SSLCommerzPayment(process.env.STORE_ID,process.env.STORE_PASSWORD,false); //true for live default false for sandbox
  sslcommer.init(data).then((data) => {
    if (data.GatewayPageURL) {
      return res.status(200).redirect(data.GatewayPageURL);
    }
    else{
      return res.status(400).json({message: "Invalid response from sslcommerz"});
    }
  });
};

exports.post_cashin3 = async (req, res) => {
  const body = req.body;
  console.log(body);
  res.send(body);
};
