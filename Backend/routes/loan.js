const express = require("express");
const router = express.Router()
const User = require("../models/user");
const Loan = require("../models/loan");
const Request = require("../models/request");
const SystemWallet = require("../models/systemWallet");
const Borrower = require("../models/borrower");
const Repay = require("../models/repay");
const Transaction = require("../models/transaction");
const Depositor = require("../models/depositor");
require('dotenv').config();
var Finance = require('financejs');
var finance = new Finance();

router.post("/:userID/apply-new-loan", async (req, res) => {

    const user = await User.findById(req.params.userID)
    var borrowerCheck = await Borrower.find({ UserID: req.params.userID, RepaymentStatus: 'Not Repaid' })
    var alreadyAppliedInALoan = await Request.find({ UserID: req.params.userID });

    console.log(borrowerCheck[0]);
    console.log(alreadyAppliedInALoan[0]);


    //borrowerCheck[0]!=null means my loan has been accepted thats why I got an entry in 
    //borrower table and hence then the borrower table will not be null
    if (alreadyAppliedInALoan[0] != null && borrowerCheck[0] == null) {
        return res.json({ success: false, message: `You have already applied for a loan` });
    }
    else if (alreadyAppliedInALoan[0] != null && borrowerCheck[0] != null) {
        var repay = await Repay.findById(borrowerCheck[0].RepaymentID);
        return res.json({ success: false, message: `Repay your Loans First` });
    }
    else {

        const amount = Number(req.body.amount);

        //creating a loan instance in the database
        var loan = new Loan({
            RecepientID: req.params.userID,
            RepaymentMonths: (req.body.months),
            LoanAmount: amount
        });
        loan = await loan.save();


        //creating a Request instance in the database
        var request = new Request({
            UserID: req.params.userID,
            LoanID: loan._id,
            RequestedAmount: req.body.amount,
            LoanRequestDate: Date.now()
        });
        request = await request.save();


        //if loan amount < threshold then provide the money from system wallet

        if (req.body.amount <= 5000) {
            const systemWallet = await SystemWallet.find({})
            if (systemWallet[0].TotalAmount > amount) {
                loan.LoanStatus = 'accepted'
                loan.SatisfiedAmount = req.body.amount
                loan.LoanEMI = (req.body.amount * req.body.months * 0.02 + req.body.amount) / req.body.months
                loan.LoanProvidedBy = 'system'
                request.ActivationDays = 0
                user.Loanwallet += req.body.amount
                user.LoanFee = req.body.amount * req.body.months * 0.02
                systemWallet[0].TotalAmount -= req.body.amount

                var transaction = new Transaction({
                    SenderID: systemWallet[0]._id,
                    ReceiverID: user._id,
                    TransactionDate: Date.now(),
                    TransactionAmount: req.body.amount,
                });
                transaction = await transaction.save();

                var repay = new Repay({
                    RepaymentDaysRemaining: req.body.months * 30,
                    RemainingInstallments: req.body.months,
                    AmountToBePaid: (req.body.amount * req.body.months * 0.02 + req.body.amount),
                });
                repay = await repay.save();

                var borrower = new Borrower({
                    UserID: req.params.userID,
                    LoanID: loan._id,
                    RepaymentID: repay._id
                });
                borrower = await borrower.save();

                loan.save()
                request.save()
                user.save()
                systemWallet[0].save()

                return res.json({ success: true, message: 'Loan Provided Successfully', loan: loan, request: request, user: user, transaction: transaction, repay: repay, borrower: borrower });
            }
            else {
                return res.json({ success: true, message: 'A2F is running out of balance.Please wait until A2F have sufficient balance', user: user, loan: loan, request: request });
            }
        }

        else {
            return res.json({ success: true, message: `Loan request submitted & will be active for ${request.ActivationDays} days`, loan: loan, request: request, user: user });
        }
    }
});

router.post("/:userID/repay-loan", async (req, res) => {
    const user = await User.findById(req.params.userID)
    const borrower = await Borrower.find({ UserID: user._id, RepaymentStatus: 'Not Repaid' })
    const loan = await Loan.findById(borrower[0].LoanID)
    const repay = await Repay.findById(borrower[0].RepaymentID)
    const systemWallet = await SystemWallet.find({})
    const amount = Number(req.body.amount)


    if (amount <= user.Wallet + user.Loanwallet - user.cashOutTillNow && amount <= repay.AmountToBePaid - repay.PaidTillNow) {


        var distributionAmount = 0
        if (user.Loanwallet >= amount && amount > 0) {
            distributionAmount = amount
            user.Loanwallet -= amount
        }
        else if (user.Loanwallet == 0 && user.LoanFee >= amount && amount > 0) {
            distributionAmount = amount * 0.75
            user.Wallet -= amount
            user.LoanFee -= amount
        }
        else if (user.Loanwallet < amount && user.LoanFee + user.Loanwallet >= amount && amount > 0) {
            distributionAmount = ((amount - user.Loanwallet) * .75) + user.Loanwallet
            user.LoanFee -= (amount - user.Loanwallet)
            user.Wallet -= (amount - user.Loanwallet)
            user.Loanwallet = 0
        }
        systemWallet[0].TotalAmount += amount
        var transaction = new Transaction({
            SenderID: user._id,
            ReceiverID: systemWallet[0]._id,
            TransactionDate: Date.now(),
            TransactionAmount: amount,
        });
        transaction = await transaction.save();
        repay.Transactions.push(transaction);
        repay.PaidTillNow += amount
        const newPrincipal = repay.AmountToBePaid - repay.PaidTillNow
        loan.LoanEMI = (newPrincipal * loan.RepaymentMonths * 0.02 + newPrincipal) / loan.RepaymentMonths
        if (repay.AmountToBePaid == repay.PaidTillNow) {
            borrower[0].RepaymentStatus = 'Paid'
            loan.LoanStatus = 'paid'

        }

        borrower[0].save()
        user.save()
        loan.save()
        repay.save()
        // systemWallet[0].save()




        if (loan.LoanProvidedBy == 'lenders') {
            const lenders = await Depositor.find({ LoanID: loan._id });

            lendersContributionDictionary = {}

            for (let i = 0; i < lenders.length; i++) {
                lendersContributionDictionary[lenders[i].UserID] = []
            }
            for (let i = 0; i < lenders.length; i++) {
                lendersContributionDictionary[lenders[i].UserID].push(lenders[i].contributionPercentage)
            }

            lendersContributionTotalDictionary = {}
            for (let k in lendersContributionDictionary) {
                const sum = lendersContributionDictionary[k].reduce((partialSum, a) => partialSum + a, 0)
                lendersContributionTotalDictionary[k] = sum;
            }


            //depositor table adjsutments
            lenders.forEach(async lender => {

                const paidAmount = distributionAmount * (lender.contributionPercentage / 100)
                lender.AmountReceivedTillNow += paidAmount
                await lender.save()
            });


            for (let k in lendersContributionTotalDictionary) {
                console.log(lendersContributionTotalDictionary[k]);
                let lenderUser = await User.findById(k)

                const paidAmount = distributionAmount * (lendersContributionTotalDictionary[k] / 100)
                systemWallet[0].TotalAmount -= paidAmount
                lenderUser.Wallet += paidAmount
                await lenderUser.save()

                var transaction = new Transaction({
                    SenderID: systemWallet[0]._id,
                    ReceiverID: lenderUser._id,
                    TransactionDate: Date.now(),
                    TransactionAmount: paidAmount,
                });
                transaction = await transaction.save();
            }

            systemWallet[0].save()

        }
        return res.json({ success: true, message: `Successfully repaid BDT${amount}`, loan: loan, user: user, transaction: transaction, repay: repay, borrower: borrower[0] });
    }

    else if (amount > user.Wallet + user.Loanwallet - user.cashOutTillNow) {
        return res.json({ success: true, message: `Insufficient Amount in Wallet` });
    }

    else if (amount > repay.AmountToBePaid - repay.PaidTillNow) {
        return res.json({ success: true, message: `Amount must be less than or equal to ${repay.AmountToBePaid - repay.PaidTillNow}` });
    }

});

router.get("/:userID/list-of-all-loans", async (req, res) => {
    const loans = await Loan.find({ LoanStatus: 'pending' })
    var filteredLoans = [];
    for (let index = 0; index < loans.length; index++) {
        if (req.params.userID != loans[index].RecepientID) {
            filteredLoans.push(loans[index]);
        }

    }
    return res.json({ success: true, loans: filteredLoans });
});

router.post("/:userID/:loanID/contribute-to-a-loan", async (req, res) => {

    const loan = await Loan.findById(req.params.loanID)
    const user = await User.findById(req.params.userID)
    const request = await Request.find({ LoanID: loan._id })
    const systemWallet = await SystemWallet.find({})
    const amount = Number(req.body.amount);



    console.log(user.Wallet + user.Loanwallet - user.cashOutTillNow);
    if (amount < user.Wallet + user.Loanwallet - user.cashOutTillNow && amount > 0) {

        if (amount <= loan.LoanAmount - loan.SatisfiedAmount) {




            var depositor = new Depositor({
                UserID: user._id,
                AmountContributed: amount,
                contributionPercentage: (amount / loan.LoanAmount) * 100,
                AmountToBeReceived: amount + amount * loan.RepaymentMonths * 0.015,
                LoanID: loan._id,
            });
            depositor = await depositor.save();

            if (amount <= user.Loanwallet) {
                user.Loanwallet -= amount;
            }
            else {
                user.Wallet -= (amount - user.Loanwallet);
                user.Loanwallet = 0;
            }




            systemWallet[0].TotalAmount += amount

            var transaction = new Transaction({
                SenderID: user._id,
                ReceiverID: systemWallet[0]._id,
                TransactionDate: Date.now(),
                TransactionAmount: amount,
            });
            transaction = await transaction.save();


            loan.SatisfiedAmount += amount
            console.log(loan.SatisfiedAmount);
            if (loan.LoanAmount == loan.SatisfiedAmount) {
                const loanRecepient = await User.findById(loan.RecepientID)
                loan.LoanStatus = 'accepted'
                loan.LoanEMI = (loan.LoanAmount * loan.RepaymentMonths * 0.02 + loan.LoanAmount) / loan.RepaymentMonths
                loanRecepient.LoanFee = loan.LoanAmount * loan.RepaymentMonths * 0.02
                request[0].ActivationDays = 0
                loanRecepient.Loanwallet += loan.LoanAmount
                systemWallet[0].TotalAmount -= loan.LoanAmount

                var transaction = new Transaction({
                    SenderID: systemWallet[0]._id,
                    ReceiverID: loanRecepient._id,
                    TransactionDate: Date.now(),
                    TransactionAmount: loan.LoanAmount,
                });
                transaction = await transaction.save()

                var repay = new Repay({
                    RepaymentDaysRemaining: loan.RepaymentMonths * 30,
                    RemainingInstallments: loan.RepaymentMonths,
                    AmountToBePaid: (loan.LoanAmount * loan.RepaymentMonths * 0.02 + loan.LoanAmount),
                });
                repay = await repay.save();

                var borrower = new Borrower({
                    UserID: loanRecepient._id,
                    LoanID: loan._id,
                    RepaymentID: repay._id
                });
                borrower = await borrower.save();

                request[0].save()
                loanRecepient.save()
            }
            loan.save()
            user.save()
            systemWallet[0].save()
            return res.json({ success: true, message: `Contribution of ${amount} BDT to a loan is successful` });

        }
        else {
            return res.json({ success: true, message: `Lending amount should be less than or equal${loan.LoanAmount - loan.SatisfiedAmount} BDT` });
        }

    } else {
        return res.json({ success: true, message: `Insufficient Amount in Wallet` });
    }

});

module.exports = router;