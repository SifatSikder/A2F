const jwt = require("jsonwebtoken");

function authenticate (req,res,next) {

    try {
        const token = req.headers['authorization'].split(' ')[1];
        jwt.verify(token,process.env.SECRET_KEY,(error)=>{
            if (error)
            {
                return res.status(401).send({
                    success : false,
                    message : 'Invalid token',
                
                })
            }
            
            next();
        })
    } catch (error) {
        return res.status(500).send({
        success : false,
        message : error.message
      }) 
    }
}

module.exports = authenticate;