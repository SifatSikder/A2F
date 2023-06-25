const express = require("express");
const router = express.Router();
const User = require("../models/user");
const Cfm = require("../models/CFM");

var jwt = require('jwt-simple')
require('dotenv').config();
require("../config/passportJWT");


router.get('/change/:adminid/:userid/:usertype', (req, res) => {

    var admin = User.findById(req.params.adminid);
    var user = User.findById(req.params.userid);

    if (admin.usertype == 'admin') {
        user.usertype = req.params.usertype;
    }
    admin.save();
    user.save();
    return res.json({ success: true, message: `User type changed successfully` });
})

router.post('/:adminid/createCFM', async (req, res) => {
    console.log('code is here');
    var admin = await User.findById(req.params.adminid);
    var cfm = new Cfm({
        creator: req.params.adminid,
        amtReq: req.body.amount,
        startingdate: Date.now(),
        dateDue: req.body.date * 30,
        dateRemaining: (req.body.date * 30) - 1,
    });
    cfm = await cfm.save();
    console.log('code');
    return res.json({ success: true, message: `Call for money has been created successfully` });
})

module.exports = router;