const mongoose = require('mongoose');

const cfmSchema =new mongoose.Schema({
    creator:{type:mongoose.Schema.Types.ObjectId,ref: 'User'},
    collablender: 
    [{
        _id: {type: mongoose.Schema.Types.ObjectId,ref: 'User'},
        amtcontrib: {type: Number}             
    }],
    amtReq:{type: Number, required: true},
    amtSatisfied:{type: Number, default: 0},
    startingdate:{type: Date,required: true},
    dateDue: {type: Number, default: 60,required: true},
    dateRemaining: {type:Number},
})

module.exports = mongoose.model('Cfms', cfmSchema);