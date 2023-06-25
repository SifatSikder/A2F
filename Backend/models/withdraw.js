const mongoose = require('mongoose');

//withdraw(withdrawID,withdrawerID,agentID,cashOutAmount,withdrawPlatformName,withdrawPlatformNumber,withdrawDate,withdrawalCompleteStatus)

const withdrawSchema =mongoose.Schema({
    withdrawerID :{type:mongoose.Schema.Types.ObjectId,required:true},
    agentID :{type:mongoose.Schema.Types.ObjectId,default:null},
    cashOutAmount:{type:Number,required:true},
    withdrawPlatformName:{type:String,required:true},
    withdrawPlatformNumber:{type:String,required:true},
    withdrawDate:{type: Date,required:true},
    withdrawalCompleteStatus :{type: String,default:'Incomplete'},
})

module.exports = mongoose.model('Withdraw', withdrawSchema);