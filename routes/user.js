const express = require("express");
const router = express.Router();
const User = require("../models/user");
const Loan = require("../models/loan");
const CFM = require("../models/cfm");
require("../config/passport");
const passport = require('passport')
const multer = require("multer");
const fs = require("fs-extra");
const bcrypt = require('bcrypt');
const saltRounds = 10;
const jwt = require('jsonwebtoken');
require('dotenv').config();

var uploadtest = multer({ limits: { fileSize: 2000000 }, dest: "./uploads/" });
router.get("/new", (req, res) => {
  message = "";
  res.status(200).render("user/signup", { message });
});

router.post("/new", uploadtest.single("profilePic"),async (req, res) => {
  try {
    if (req.file == null) 
    {
      res.render("user/signup", { message: "Complete all fields" });
    } 
    else 
    {
      var newImg = fs.readFileSync(req.file.path);
      var encImg = newImg.toString("base64");
      const user= await User.findOne({email: req.body.email});
      if(user) res.render("user/signup", { message: "User already exists" });
      bcrypt.hash(req.body.password, saltRounds, async(err, hash) =>{
        if(err) console.log(err);
        const newUser = new User({
          username: req.body.username,
          email: req.body.email,
          UniversityRegistrationID: req.body.UniversityRegistrationID,
          password: hash,
          PhoneNumber: req.body.PhoneNumber,
          bKashNumber: req.body.bKashNumber,
          gender: req.body.gender,
          currentBsseYear: req.body.currentBsseYear,
          profilePic: encImg,
        });
        await newUser.save();
        res.redirect("login");
      });
  
    }
  } catch (error) {console.log(error); res.redirect("new");}
});

router.get("/login", (req, res) => {
  res.render("user/login");
});

router.post("/login",passport.authenticate("local", {
    successRedirect: "/user/dashboard",
    failureRedirect: "/user/login",
  })
);

// router.post("/login", async(req, res) => {
//   const user= await User.findOne({ email: req.body.username})
//   if((!user)) return res.redirect("login");
//   if( (!await bcrypt.compare(req.body.password, user.password)))return res.redirect("login");
//   const token = jwt.sign({id: user._id, email: user.email}, process.env.SESSION_SECRET,{expiresIn:"1h"});
//   req.headers.authorization= "Bearer "+token;
//   // console.log(req.headers);
//   res.redirect("dashboard");
// });


router.get("/dashboard", isLoggedIn, (req, res) => {
  // console.log(req);
  User.findById(req.user._id, (err, user) => {
    if (err) {
      console.log(err);
    } else {
      // console.log(user.profilePic.substring(6));
      Loan.find(
        { recepient: req.user._id, status: "pending" },
        (err, pendingLoans) => {
          // console.log(pendingLoans);
          if (err) {
            console.log(err);
          } else {
            Loan.find(
              { recepient: req.user._id, status: "accepted" },
              (err, acceptedLoans) => {
                if (err) {
                  console.log(err);
                } else {
                  Loan.find(
                    { "collablender._id": req.user._id },
                    (err, collabLoans) => {
                      if (err) {
                        console.log(err);
                      } else {
                        CFM.find({}, (err, cfms) => {
                          if (err) {
                            console.log(err);
                          } else {
                            res.render("user/dashboard/dashboard", {
                              cfms: cfms,
                              user: user,
                              collabLoans: collabLoans,
                              acceptedLoans: acceptedLoans,
                              pendingLoans: pendingLoans,
                            });
                          }
                        });
                      }
                    }
                  );
                }
              }
            );
          }
        }
      );

      //  res.render('user/dashboard/dashboard',{user:user});
    }
  });
});



// router.get("/dashboard", check ,passport.authenticate('jwt', { session: false }), (req, res) => {
//   // console.log(req);
//   User.findById(req.user._id, (err, user) => {
//     if (err) {
//       console.log(err);
//     } else {
//       // console.log(user.profilePic.substring(6));
//       Loan.find(
//         { recepient: req.user._id, status: "pending" },
//         (err, pendingLoans) => {
//           // console.log(pendingLoans);
//           if (err) {
//             console.log(err);
//           } else {
//             Loan.find(
//               { recepient: req.user._id, status: "accepted" },
//               (err, acceptedLoans) => {
//                 if (err) {
//                   console.log(err);
//                 } else {
//                   Loan.find(
//                     { "collablender._id": req.user._id },
//                     (err, collabLoans) => {
//                       if (err) {
//                         console.log(err);
//                       } else {
//                         CFM.find({}, (err, cfms) => {
//                           if (err) {
//                             console.log(err);
//                           } else {
//                             res.render("user/dashboard/dashboard", {
//                               cfms: cfms,
//                               user: user,
//                               collabLoans: collabLoans,
//                               acceptedLoans: acceptedLoans,
//                               pendingLoans: pendingLoans,
//                             });
//                           }
//                         });
//                       }
//                     }
//                   );
//                 }
//               }
//             );
//           }
//         }
//       );

//       //  res.render('user/dashboard/dashboard',{user:user});
//     }
//   });
// });

router.get("/showCFM", isLoggedIn, (req, res) => {
  CFM.find({}, (err, cfms) => {
    if (err) {
      console.log(err);
    } else {
      User.findById(req.user._id, (err, user) => {
        if (err) {
          console.log(err);
        } else {
          res.render("cfm/showCFM", { cfms: cfms, user: user });
        }
      });
    }
  });
});

router.get("/investCFM", isLoggedIn, (req, res) => {
  CFM.find({}, (err, cfms) => {
    if (err) {
      console.log(err);
    } else {
      User.findById(req.user._id, (err, user) => {
        if (err) {
          console.log(err);
        } else {
          res.render("cfm/showCFM", { cfms: cfms, user: user });
        }
      });
    }
  });
});

router.get("/amountCFM", isLoggedIn, (req, res) => {
  CFM.find({}, (err, cfms) => {
    User.findById(req.user._id, (err, user) => {
      res.render("cfm/InvestCFM", { cfms: cfms, user: user });
    });
  });
});

router.post('/amountCFM', (req, res) => {
    
    CFM.find({}, (err, cmfs) => {
        if (err) {console.log(err);} 
        else 
        {
            cmfs.forEach(cfm => {
                if (req.body.amount <= (cfm.amtReq - cfm.amtSatisfied) && req.body.amount > 0) {
                    User.findById(req.user._id, (err, user) => {
                        if (err) { console.log(err);} 
                        else 
                        {
                            if (user.wallet >= req.body.amount) 
                            {
                                cfm.collablender.push({ _id: user._id, amtcontrib: req.body.amount })
                                let newsat = parseInt(cfm.amtSatisfied) + parseInt(req.body.amount);
                                cfm.amtSatisfied = newsat;
                                user.wallet = parseInt(user.wallet) - parseInt(req.body.amount);
                                cfm.save();
                                user.save();
                                res.redirect('/user/dashboard');
                            }
                            else {res.redirect('/user/dashboard');}
                        }
                    })
                }
                else 
                {
                    res.redirect('/user/amountCFM');
                }
            })
        }
    })
})


function isLoggedIn(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  res.redirect("/user/login");
}

router.get("/logout", (req, res) => {
  req.logOut();
  res.redirect("/");
});

// router.get('/test',isLoggedIn,(req,res)=>{
//     res.render('test');
// });

// router.post('/test',uploadtest.single('pic1'),(req,res)=>{
//     if(req.file == null){
//         res.render('/test',{message: 'Upload!'});
//     }else{
//         var newImg = fs.readFileSync(req.file.path);
//         var encImg = newImg.toString('base64');

//         User.findById(req.user._id,(err,user)=>{
//             user.profilePic = encImg;
//             user.save();
//             fs.remove(req.file.path,(err)=>{
//                 res.render('success');
//             })
//         });
//     }
// });

// router.get('/all',(req,res)=>{
//     User.find({},(err,users)=>{
//         res.send(users);
//     })
// })

// router.get('/final',isLoggedIn,(req,res)=>{
//     User.findById(req.user._id,(err,user)=>{
//       res.render('final',{user});
//     })
// })

// var storageKyc = multer.diskStorage({
//     destination: 'public/userAssets/uploads/kyc',
//     filename: function (req, file, cb) {
//       cb(null, file.fieldname + '-' + Date.now()+ '.jpg')
//     }
// })
// var upload = multer({ storage: storage })

router.post("/flush/:id", (req, res) => {
  User.findById(req.params.id, (err, user) => {
    if (user.wallet >= req.body.trans) {
      user.withdrawAmount += req.body.trans;
      user.save();
    }
  });
  res.redirect("/user/dashboard");
});

// router.get ('/kyc',isLoggedIn,(req,res)=>{
//     res.render('user/kyc',{message:""});
// })

// router.post('/kyc',isLoggedIn,uploadtest.fields([
//     { name:'adhaarImage' ,maxCount:1 },
//     { name:'panImage' ,maxCount:1 },
//     { name:'salarySlip' ,maxCount:1 }
// ]),(req,res)=>{

//     if(req.files == null){
//         res.render('user/kyc',{message:'Upload all images'})
//     }
//     else{
//         var newAdhaar = fs.readFileSync(req.files.adhaarImage[0].path);
//         var encAd = newAdhaar.toString('base64');
//         var newPan = fs.readFileSync(req.files.panImage[0].path);
//         var encPa = newPan.toString('base64');
//         var newSal = fs.readFileSync(req.files.salarySlip[0].path);
//         var encSal = newSal.toString('base64');
//         Kyc.create({
//             adhaarno:req.body.adhaarno,
//             panno: req.body.panno,
//             salary: req.body.salary,
//             profile: req.body.profile,
//             adhaarImage: encAd,
//             panImage: encPa,
//             salarySlip :encSal
//         },(err,kyc)=>{

//             if(err){
//                 console.log(err);
//             }
//            // console.log(kyc);
//             fs.remove(req.files.adhaarImage[0].path,(err)=>{
//                 fs.remove(req.files.panImage[0].path,(err2)=>{
//                     fs.remove(req.files.salarySlip[0].path,(err3)=>{
//                         User.findById(req.user._id,(err,user)=>{
//                             user.kyc=kyc._id;
//                             user.save();
//                             res.redirect('/user/dashboard');
//                         })

//                     })
//                 })
//             })

//         })
//     }

// });

// router.get('/profile/:id',isLoggedIn,(req,res)=>{
// User.findById(req.params.id,(err,user)=>{
//     User.findById(req.user._id,(err,loguser)=>{
//         res.render('user/dashboard/user',{user:user,luser:loguser});
//     })

// });

// })

module.exports = router;
