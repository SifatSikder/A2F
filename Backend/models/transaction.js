const mongoose = require('mongoose');

//transaction(TransactionID,SenderID,ReceiverID,TransactionDate,TransactionAmount)

const transactionSchema =mongoose.Schema({
    SenderID :{type:mongoose.Schema.Types.ObjectId},
    ReceiverID :{type:mongoose.Schema.Types.ObjectId},
    TransactionDate:{type: Date},
    TransactionAmount :{type: Number},
})

module.exports = mongoose.model('Transaction', transactionSchema);