const SystemWallet = require("../models/systemWallet");


const createWallet =  async function(){
    
    const wallet=await SystemWallet.find({})
    if(wallet.length==0)
    {
        var systemWallet = new SystemWallet({});
        systemWallet.save();
    }
}

createWallet()



