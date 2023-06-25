const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

//User(Email,Wallet,PhoneNumber,Username,UID,UniRegID,UserType,
//Password,BkashNumber,CurrentYear)

const userSchema =mongoose.Schema({
    email : {type:String,unique: true},
    password : {type: String,required: true},
    username : {type: String, required: true},
    usertype: {type: String, default: 'general'},
    UniversityRegistrationID: {type:String,default: 'N/A'},
    PhoneNumber: {type: String,required: true},
    bKashNumber: {type: String,required: true},
    LoanFee: {type: Number, default: 0},
    Loanwallet: {type: Number, default: 0},
    Wallet: {type: Number, default: 0},
    withdrawAmount:{type: Number, default: 0},
    cashOutTillNow: {type: Number, default: 0},
    currentBsseYear:{type:String,default: 'N/A'},

})

userSchema.pre('save', function (next) {
    var user = this;
    if (this.isModified('password') || this.isNew) {
        bcrypt.genSalt(10, function (err, salt) {
            if (err) {
                return next(err)
            }
            bcrypt.hash(user.password, salt, function (err, hash) {
                if (err) {
                    return next(err)
                }
                user.password = hash;
                next()
            })
        })
    }
    else {
        return next()
    }
})

userSchema.methods.comparePassword = function(password,callback){
    bcrypt.compare(password, this.password, function (err, isMatch) {
        if (err) {
            return callback(err)
        }
        callback(null, isMatch)
    })
}

module.exports = mongoose.model('User', userSchema);