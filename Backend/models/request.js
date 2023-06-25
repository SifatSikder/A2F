const mongoose = require('mongoose');

//Request(UserID,LoanID,RequestedAmount,LoanRequestDate,ActivationDays)

const requestSchema =mongoose.Schema({
    UserID :{type:mongoose.Schema.Types.ObjectId,ref: 'User'},
    LoanID :{type:mongoose.Schema.Types.ObjectId,ref: 'Loan'},
    RequestedAmount :{type: Number},
    LoanRequestDate:{type: Date},
    ActivationDays:{type:Number,default:7},
})

module.exports = mongoose.model('Request', requestSchema);