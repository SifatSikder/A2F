const mongoose = require('mongoose');
// const passportLocalMongoose = require('passport-local-mongoose');

const userSchema =mongoose.Schema({
    username : {type: String, required: true},
    email : {type:String,unique: true},
    UniversityRegistrationID: {type:String,required: true},
    password : {type: String,required: true},
    PhoneNumber: {type: String,required: true},
    bKashNumber: {type: String,required: true},
    gender:{type:String},
    currentBsseYear:{type:String},
    profilePic:{type: String},
    
    usertype: {type: String, default: 'general'},
    loans: [{type:mongoose.Schema.Types.ObjectId,ref:'Loan'}],
    acceptedLoans: {type: Number, default: 0},
    lends:[{type: mongoose.Schema.Types.ObjectId, ref: 'Loan'}],
    wallet: {type: Number, default: 0},
    withdrawAmount: {type: Number, default: 0},
    withdrawAgent: 
    [{
        _id: {type: mongoose.Schema.Types.ObjectId,ref: 'User'},
        withdrawAmount: {type: Number}
                 
    }],
    notifications: [{type:String}],

})
// userSchema.plugin(passportLocalMongoose);


module.exports = mongoose.model('User', userSchema);