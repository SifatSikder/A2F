const express = require('express');
const router  = express.Router();
const User = require('../models/user');
const CFM = require('../models/cfm');
const passport = require('passport');


router.get('/login',(req,res)=>{
    res.render('admin/login');
});

router.post('/login',passport.authenticate("local",{
    successRedirect: "/admin/dashboard",
    failureRedirect: "/admin/login"
}),(req,res)=>{});


router.get('/dashboard',isAdminAndLoggedIn,(req,res)=>{
    User.find({},(err,users)=>{
        var generalUsers = users.filter(user=>{return (user.usertype==='general');})
        generalUsers.reverse();

        var admins = users.filter(user=>{return (user.usertype==='admin');})
        admins.reverse();
        var agents = users.filter(user=>{return (user.usertype==='agent');})
        agents.reverse();
        var committeeMembers = users.filter(user=>{return (user.usertype==='committee member');})
        committeeMembers.reverse();

        User.findById(req.user._id,(err,user)=>{
            res.render('admin/adminHome',{users: generalUsers,admins: admins,agents:agents,committeeMembers:committeeMembers,user:user});
        })
        
    })
 
})


router.get('/change/:userid/:usertype',(req,res)=>{
    User.findById(req.user._id,(err,admin)=>{
        console.log(req.params);
        User.findById(req.params.userid,(err,user)=>{
            user.usertype = req.params.usertype;
            user.save();
            return res.redirect('//localhost:8000/admin/dashboard');
        }) 
    }) 
})

router.get('/createCFM',(req,res)=>{
    res.render('cfm/createCFM');
})

router.post('/createCFM',isAdminAndLoggedIn,(req,res)=>{
    console.log(req.body);
    CFM.create({
            creator: req.user._id,
            amtReq: req.body.amount,
            startingdate: req.body.startDate,
            dateDue: req.body.date*30,
            dateRemaining: (req.body.date*30)-1,
        }, (err, cfm) => {
            if (err) 
            {
                console.log(err);
                res.redirect('/admin/createCFM');
            } 
            else 
            {
                res.redirect('/admin/dashboard');
            }
    
    })
})



function isAdminAndLoggedIn(req,res,next){
    if(req.isAuthenticated()){
        if(req.user.usertype === 'admin'){
            return next();
        }
        else{
            return res.redirect('/admin/login');
        }
    }
    return res.redirect('/admin/login');
}
module.exports = router;










// router.get('/new',(req,res)=>{
//     res.render('admin/newadmin')
// });

// router.post('/new',(req,res)=>{   
//     var newUser = new User({username: req.body.username, name: req.body.name, isAdmin: 'yes'});
//     User.register(newUser,req.body.password, (err,user)=>{
//         if(err){
//             console.log(err);
//             res.redirect('/')
//         }
//         passport.authenticate("local")(req,res, ()=>{
//         res.redirect(`/admin/dashboard`);
//         })
//     } );

// });



// router.post('/kyc/delete/:kycid/user/:userid',isAdminAndLoggedIn,(req,res)=>{
//     Kyc.findById(req.params.kycid,(err,kyc)=>{
//         User.findById(req.params.userid,(err,user)=>{
//             user.kyc = null;
//             user.save();
//             res.redirect('/admin/dashboard');

//         })
//     })
// })