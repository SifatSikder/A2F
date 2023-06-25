const mongoose = require('mongoose');

//Depositor(UserID,AmountContributed,LoanID)

const depositorSchema =mongoose.Schema({
    UserID :{type:mongoose.Schema.Types.ObjectId,ref: 'User'},
    AmountContributed :{type: Number},
    LoanID :{type:mongoose.Schema.Types.ObjectId,ref: 'Loan'},
    contributionPercentage:{type: Number},
    AmountToBeReceived :{type: Number},
    AmountReceivedTillNow :{type: Number,default:0},
})

module.exports = mongoose.model('Depositor', depositorSchema);