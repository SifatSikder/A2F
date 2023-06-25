const mongoose = require('mongoose');

//Repay(UserID,WalletID,RepaymentDaysRemaining,PaidAmount,RemainingInstallments)

const repaySchema =mongoose.Schema({
    Transactions:[{type:mongoose.Schema.Types.ObjectId,ref: 'Transaction'}],
    PaidTillNow :{type: Number,default:0},
    AmountToBePaid :{type: Number},
    RepaymentDaysRemaining:{type: Number},
    RemainingInstallments :{type: Number},
})

module.exports = mongoose.model('Repay', repaySchema);