const express = require('express');
const router = express.Router();
const User = require('../models/user');
const Loan = require('../models/loan');
const nodemailer = require("nodemailer");
var Finance = require('financejs');
var finance = new Finance();


//showing all loans

router.get('/showall', isLoggedIn, (req, res) => {
    Loan.find({}, (err, loans) => {
        if (err) {
            console.log(err);
        } else {
            var filterLoans = loans.filter(loan => {

                return (!loan.recepient.equals(req.user._id));
            })
            filterLoans.reverse();

            User.findById(req.user._id,(err,user)=>{
                if(err){
                    console.log(err);
                }else{
                    res.render('loan/all', { loans: filterLoans ,user:user});
                }
            })
            
        }
    });
});


//new loan routes

router.get('/new', isLoggedIn, (req, res) => {
   
    res.render('loan/newloan');
});

router.get('/daterem/:loanid',(req,res)=>{
    Loan.findById(req.params.loanid,(err,loan)=>{
        res.json(loan.dateRemaining);
    });
});

router.post("/new", isLoggedIn, (req, res) => {
    Loan.create({
        recepient: req.user._id,
        amtReq: req.body.amount,
        dateRequested: Date.now(),
        dateDue: req.body.date*30,
        dateRemaining: (req.body.date*30)-1,
        emi: finance.AM(req.body.amount,5,req.body.date,1)
    }, (err, loan) => {
        if (err) {
            console.log(err);
            res.redirect('/loan/new');
        } else {
            User.findById(req.user._id, (err, user) => {
                if (err) {
                    console.log(err);
                } else {
                    user.loans.push(loan._id);
                    user.save();
                    res.redirect(`/loan/${loan._id}`);
                }

            })

        }

    })
})



//loan details

router.get('/:loanid', isLoggedIn, (req, res) => {
    Loan.findById(req.params.loanid, (err, loan) => {
        User.findById(req.user._id,(err,user)=>{
            User.findById(loan.recepient,(err,recepient)=>{
                res.render('loan/loandetails', { loan: loan,user:user ,recepient:recepient});
            })
        })
    })
})



//lending routes


router.get('/:loanid/lend', isLoggedIn, (req, res) => {
    Loan.findById(req.params.loanid, (err, loan) => {
        if (err) {
            console.log(err);
        } else {
           
            User.findById(req.user._id,(err,user)=>{
                res.render('loan/bid', { loan:loan ,user:user});
            })
           
        }
    });

});


router.post('/:loanid/lend', (req, res) => {
    
    Loan.findById(req.params.loanid, (err, loan) => {
        if (err) {
            console.log(err);
        } else {
            if (req.body.amount <= (loan.amtReq - loan.amtSatisfied) && req.body.amount != 0) {

                User.findById(req.user._id, (err, user) => {
                    if (err) {
                        console.log(err);
                    } else {

                        if (user.wallet >= req.body.amount) {
                            loan.collablender.push({ _id: user._id, amtcontrib: req.body.amount })
                            let newsat = parseInt(loan.amtSatisfied) + parseInt(req.body.amount);
                            loan.amtSatisfied = newsat;
                            if (loan.amtSatisfied == loan.amtReq) {
                                //console.log(loan.status);
                                loan.status = 'accepted';
                                User.findById(loan.recepient, (err, user) => {
                                    if (err) {
                                        console.log(err);
                                    } else {
                                        user.acceptedLoans +=1;
                                        user.wallet += Number(loan.amtReq);
                                        loan.collablender.forEach(lender=>{
                                            User.findById(lender._id, (err,lender)=>
                                            {
                                               if (err){
                                                   console.log(err);

                                               }
                                               else{
                                                lender.wallet-=Number(lender.amtcontrib);
                                                lender.save();
                                            }
                                            })
                                        })
                                        user.save();
                                    }

                                });
                            }
                            user.wallet = parseInt(user.wallet) - parseInt(req.body.amount);
                            loan.save();
                            user.save();
                            res.redirect(`loan/${loan._id}`);
                        }
                        else {
                            res.redirect('/loan/showall');
                        }


                    }
                })



            }
            else {
                res.redirect('/loan/showall');
            }


        }
    })

})

function isLoggedIn(req, res, next) {

    if (req.isAuthenticated()) {
        return next();
    }
    res.redirect('/user/login');
}

var dayDuration = 1000*3600*24;

var interTimer = setInterval(() => {
    Loan.find({ status: 'pending' }, (err, loans) => {
        if (err) {
            console.log(err);
        } 
        else 
        {
            //check if there exists any loan in the system
            if (loans.length !== 0) 
            {
                loans.forEach(loan => {
                    //check if the donating time is over or not
                    if (loan.timeForBid <= 0) 
                    {
                        loan.status = 'declined';
                        //if the loan is declined then distribute the money back to the lender
                        if(loan.collablender.length>0)
                        {
                            loan.collablender.forEach(lender=>{

                                User.findById(lender._id,(err,len)=>{
                                    len.wallet += Number(lender.amtcontrib);
                                    len.save();
                                });

                            })
                        }
                    }

                    //deduct the bidding time by 1
                    (async () => {
                        loan.timeForBid -= 1;
                    })();

                    loan.save();
                })
            } 
        }

    });

   
}, dayDuration);

var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'bsse1221@iit.du.ac.bd',
      pass: '01711813256sifatA@'
    }
});

var installMentTimer = setInterval(()=>{

    //find all the accepted loans list
    Loan.find({status:'accepted'},(err,loans)=>{
        loans.forEach(loan=>{
         //if loan.dateRemaining= 5 days then
           if ((30-loan.dateRemaining)%30>24)
            {
                //find the loan recepient
                User.findById(loan.recepient,(err,recepient)=>{
                if (recepient.wallet<loan.emi) //check his wallet..If not enough money then send mail
                {
                var mailOptions = {
                from: 'sikdersifat29@gmail.com',
                to: recepient.email,
                subject: `LOAN DEFAULT`,
                html: `Sir/Ma'am,<br> Your wallet balance is too low for further payments. Please, recharge your wallet immediately.<br><br>Regards,<br>A2F-Access To Funds`
              };
              transporter.sendMail(mailOptions, function(error, info){
                if (error) {
                  console.log(error);
                } else {
                  console.log('Email sent for low balance: ' + info.response);
                }
              });
        }
    })
}

            //In each remaining month
            if(loan.dateRemaining%30===0 && loan.dateRemaining>=0)
            {
                //find the loan recepient
                User.findById(loan.recepient,(err,recepient)=>{
                    previous_recepient_wallet_amount =recepient.wallet
                    recepient.wallet-=loan.emi;//deduct installment
                    //check whether the wallet after deducting installment is empty or not..If no
                    if(recepient.wallet>0){
                        recepient.save();
                        //distribute installment amount to lender wallets
                        loan.collablender.forEach(lender=>{
                            User.findById(lender._id, (err,lenderr)=>{
                                //console.log(parseFloat((lender.amtcontrib/loan.amtReq)*(loan.emi)));
                                lenderr.wallet += parseFloat((lender.amtcontrib/loan.amtReq)*(loan.emi));
                                lenderr.save();
                            });
                        })
                    }else{
                            //after deducting installment if the wallet is empty then,,,send a mail
                            loan.status = 'default';
                            amount_shortage=loan.emi-previous_recepient_wallet_amount
                            var mailOptions = {
                                from: 'sikdersifat29@gmail.com',
                                to: recepient.email,
                                subject: `Balanced Finished`,
                                html: `Sir/Ma'am,<br> You have ${amount_shortage} tk due installments to pay.  Please, recharge your wallet immediately.<br><br>Regards,<br>A2F-Access To Funds`
                              };

                              transporter.sendMail(mailOptions, function(error, info){
                                if (error) {
                                  console.log(error);
                                } else {
                                  console.log('Email sent for loan default: ' + info.response);
                                }
                              });

                              loan.save();

                    }  
                });

            }


            //if this condition is true that means the loan is paid
            else if(loan.dateRemaining<0)
            {
                loan.status = 'paid';
            }
            
            //make the loan status paid condition enable
            loan.dateRemaining-=1;
            loan.save();
        })
    })
},dayDuration);



module.exports = router;
