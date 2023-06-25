const express = require("express");
const router = express.Router();
const User = require("../models/user");
const Loan = require("../models/loan");
const Depositor = require("../models/depositor");
const Withdraw = require("../models/withdraw");
const Borrower = require("../models/borrower");
const Repay = require("../models/repay");
const Transaction = require("../models/transaction");
var jwt = require('jwt-simple')
require('dotenv').config();
require("../config/passportJWT");
// router.post("/new",async (req, res) => {

// });

router.post("/new", async (req, res) => {


    //Email and password is necessary to register    
    if ((!req.body.email) || (!req.body.password)) {
        return res.json({ success: false, msg: 'Enter all fields' })
    }
    else {
        const user = await User.findOne({ email: req.body.email });
        if (user) return res.json({ success: false, message: "User already exists" });
        else {
            const newUser = new User({
                password: req.body.password,
                email: req.body.email,
                username: req.body.username,
                usertype: req.body.usertype,
                UniversityRegistrationID: req.body.UniversityRegistrationID,
                PhoneNumber: req.body.PhoneNumber,
                bKashNumber: req.body.bKashNumber,
                wallet: req.body.wallet,
                currentBsseYear: req.body.currentBsseYear,
            });

            newUser.save((err, newUser) => {
                if (err) {
                    return res.json({ success: false, msg: 'User Registration Unsuccessful' })
                }
                else {
                    return res.json({ success: true, msg: 'User Registration Successful' })
                }
            })
        }
    }
});

router.post("/login", async (req, res) => {


    const user = await User.findOne({ email: req.body.email })
    if (!user) {
        return res.status(403).json({ success: false, msg: 'Authentication Failed, User not found' })
    }
    else {
        user.comparePassword(req.body.password, function (err, isMatch) {
            if (isMatch && !err) {
                var token = jwt.encode(user, process.env.SESSION_SECRET)
                return res.json({ success: true, token: token })
            }
            else {
                return res.status(403).json({ success: false, msg: 'Authentication failed, wrong password' })
            }
        })
    }
});

router.get("/dashboard", async (req, res) => {
    if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
        var token = req.headers.authorization.split(' ')[1]
        var user = jwt.decode(token, process.env.SESSION_SECRET)

        var user = await User.findById(user._id);
        if (user == null) {
            return res.json({ success: false, message: 'Invalid Credentials' });
        }


        var loan = await Loan.find({ RecepientID: user._id });
        var contributedLoans = await Depositor.find({ UserID: user._id });

        var pendingLoans = await Borrower.find({ UserID: user._id });
        pendingLoans = pendingLoans[0];
        var repaymentDetails = []
        if (pendingLoans != null) {
            var a = await Repay.findById(pendingLoans.RepaymentID);
            repaymentDetails.push(a);
        }

        //   var cfms = await CFM.find({})
        //   return res.json({cfms: cfms,user: user,collabLoans: collabLoans,acceptedLoans: acceptedLoans,pendingLoans: pendingLoans});
        return res.json({ success: true, user: user, loan: loan, contributedLoans: contributedLoans, repaymentDetails: repaymentDetails });
    }
    else {
        return res.json({ success: false, msg: 'No Headers' })
    }
});

router.post("/:userID/cash-in", async (req, res) => {
    var user = await User.findById(req.params.userID);
    var amount = Number(req.body.amount);

    user.Wallet += amount
    await user.save();

    return res.json({ success: true, message: `Successfully recharged BDT ${amount}` });

});

router.post("/:userID/cash-out", async (req, res) => {

    const cashOutamount = Number(req.body.amount);

    var user = await User.findById(req.params.userID);

    if ((user.Wallet + user.Loanwallet) < cashOutamount) {
        return res.json({ success: false, message: `Insufficient Balance` });
    }
    else {

        user.withdrawAmount += cashOutamount;
        var withdrawDetails = new Withdraw({
            withdrawerID: user._id,
            cashOutAmount: cashOutamount,
            withdrawPlatformName: req.body.platformName,
            withdrawPlatformNumber: req.body.platformNumber,
            withdrawDate: Date.now(),
        });
        withdrawDetails = await withdrawDetails.save();
        await user.save();
        return res.json({ success: true, message: `Withdrawal Request Submitted` });
    }
});

router.get("/:agentID/transaction-list", async (req, res) => {

    var agent = await User.findById(req.params.agentID);

    if (agent.usertype == 'agent') {
        var transactions = await Withdraw.find({});
        var incompleteTransactions = [];
        for (let index = 0; index < transactions.length; index++) {
            if (transactions[index].withdrawalCompleteStatus == 'Incomplete') {
                incompleteTransactions.push(transactions[index]);
            }
        }
        return res.json({ success: true, transactions: incompleteTransactions, message: '' });
    }
    else {
        return res.json({ success: false, message: `You do not have permission to view this data` });
    }



});

router.get("/:agentID/:withdrawID/complete-a-withdraw-request", async (req, res) => {

    var agent = await User.findById(req.params.agentID);

    if (agent.usertype == 'agent') {
        var withdrawRequest = await Withdraw.findById(req.params.withdrawID);
        withdrawRequest.agentID = req.params.agentID;
        withdrawRequest.withdrawalCompleteStatus = 'complete';
        withdrawRequest.withdrawDate = Date.now();

        var withdrawer = await User.findById(withdrawRequest.withdrawerID);
        withdrawer.cashOutTillNow += Number(withdrawRequest.cashOutAmount);
        withdrawer.withdrawAmount -= Number(withdrawRequest.cashOutAmount);;
        await withdrawRequest.save();
        await withdrawer.save()

        var transaction = new Transaction({
            SenderID: withdrawer._id,
            ReceiverID: null,
            TransactionDate: Date.now(),
            TransactionAmount: withdrawRequest.cashOutAmount,
        });
        transaction = await transaction.save();
        return res.json({ success: true, message: `Withdrawal of ${withdrawRequest.cashOutAmount} BDT is completed` });
    }

    else {
        return res.json({ success: false, message: `You do not have permission to view this data` });
    }
});

module.exports = router;