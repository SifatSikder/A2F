const mongoose = require('mongoose');

//SystemWallet(WalletID,TotalAmount,SenderID,ReceiverID,Date,TransactionAmount)

const systemWalletSchema =mongoose.Schema({
    TotalAmount :{type: Number,default:0},
})

module.exports = mongoose.model('SystemWallet', systemWalletSchema);