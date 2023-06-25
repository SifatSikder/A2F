const mongoose = require('mongoose');

const cfmSchema = mongoose.Schema({
    creator: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },

    amtReq: { type: Number, required: true },
    amtSatisfied: { type: Number, default: 0 },
    startingdate: { type: Date, required: true },
    dateDue: { type: Number, default: 60, required: true },
    dateRemaining: { type: Number },
})

module.exports = mongoose.model('Cfm', cfmSchema);
