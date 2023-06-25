const mongoose = require('mongoose');

//Loan(LoanID,LoanStatus,LoanEMI,RecepientID,SatisfiedAmount)

const loanSchema =mongoose.Schema({
    LoanStatus :{type: String, default: 'pending'},
    LoanEMI :{type: Number,default:0},
    RecepientID :{type:mongoose.Schema.Types.ObjectId,ref: 'User'},
    LoanAmount :{type: Number},
    SatisfiedAmount:{type: Number, default: 0},
    RepaymentMonths:{type: Number},
    LoanProvidedBy :{type: String, default: 'lenders'},
})

module.exports = mongoose.model('Loan', loanSchema);