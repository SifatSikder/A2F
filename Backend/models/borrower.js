const mongoose = require('mongoose');

//Borrower(UserID,LoanID,RepaymentID,RepaymentStatus)

const borrowerSchema =mongoose.Schema({
    UserID :{type:mongoose.Schema.Types.ObjectId,ref: 'User'},
    LoanID :{type:mongoose.Schema.Types.ObjectId,ref: 'Loan'},
    RepaymentID :{type:mongoose.Schema.Types.ObjectId,ref: 'Repay'},
    RepaymentStatus :{type: String,default:'Not Repaid'},
})

module.exports = mongoose.model('Borrower', borrowerSchema);