const express = require('express');
const router  = express.Router();
const User = require('../../A2F-v5/models/user');
const passport = require('passport');


router.get('/login',(req,res)=>{
    console.log("code is here")
    res.render('agent/login');
});

router.post('/login',passport.authenticate("local",{
    successRedirect: "/agent/dashboard",
    failureRedirect: "/agent/login"
}),(req,res)=>{});


router.get('/dashboard',isAgentAndLoggedIn,(req,res)=>{
    User.find({},(err,users)=>{
        var users_withdrawal = users.filter(user=>{return (user.withdrawAmount>0);})
        users_withdrawal.reverse();

        User.findById(req.user._id,(err,user)=>{
            res.render('agent/agentHome',{users: users_withdrawal,user:user});
        })
        
    })
 
})


router.get('/completeTransaction/:id',(req,res)=>{
    User.findById(req.user._id,(err,agent)=>{
        User.findById(req.params.id,(err,user)=>{
            user.withdrawAgent.push({ _id: req.user._id, withdrawAmount: user.withdrawAmount })
            user.wallet -=user.withdrawAmount
            user.withdrawAmount = 0;
            user.save();
            return res.redirect('//localhost:8000/agent/dashboard');
        }) 
    }) 
});


function isAgentAndLoggedIn(req,res,next){
    if(req.isAuthenticated()){
        if(req.user.usertype === 'agent'){
            return next();
        }
        else{
            return res.redirect('/agent/login');
        }
    }
    return res.redirect('/agent/login');
}
module.exports = router;