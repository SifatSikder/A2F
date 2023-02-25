const pool = require("../../model/connection");
const joi = require("joi");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");


//All get functions this function
// exports.home = (req, res) => {
//   res.render("../views/phase-1/home");
// };

// exports.get_register = (req, res) => {
//   console.log("This is view", req.url);
//   res.render("../views/phase-1/register", { layout: false, exists: false });
// };

// exports.get_login2 = (req, res) => {
//   res.render("../views/phase-1/login2", { layout: false });
// };

// exports.get_dashboard = (req, res) => {
//   res.render("../views/phase-2/dashboard", { layout: false });
// };




//---------------------------Main backend logics----------------

exports.post_register = (req, res) => {
  //1.taking the database connection
  pool.getConnection(async (err, connection) => {
    if (err) throw err;
    let data = req.body;

    //2.data validation using joi
    const joi_schema = joi.object({
      Username: joi.string().min(3).max(100).required(),
      email: joi.string().email().required(),
      UniversityRegistrationID: joi.string().min(0),
      password: joi.string().min(6).max(10).required(),
      PhoneNumber: joi.string().pattern(new RegExp(/(^(\+88|0088)?(01){1}[3456789]{1}(\d){8})$/)).required(),
      bKashNumber: joi.string().pattern(new RegExp(/(^(\+88|0088)?(01){1}[3456789]{1}(\d){8})$/)).required(),
    });
    const validation = joi_schema.validate(data);
    if (validation.error) {
      return res.send({
        success: false,
        message: validation.error.details[0].message,
      });
    }

    //3.hashing the password
    const salt = await bcrypt.genSalt(15);
    data.password = await bcrypt.hash(data.password, salt);

    //4.save the data to the database
    connection.query(
      "select count(*) as count from User where InstitutionalEmail = ?",
      [data.email],
      (err, rows) => {
        console.log(rows[0].count);
        if (rows[0].count < 1) {
          connection.query(
            "INSERT INTO User SET Name = ?, InstitutionalEmail = ?, UniversityRegistrationID = ?, Password = ?,PhoneNumber = ?,bKashNumber = ?",
            [
              data.Username,
              data.email,
              data.UniversityRegistrationID,
              data.password,
              data.PhoneNumber,
              data.bKashNumber,
            ],
            (err, rows) => {
              connection.release();
              if (!err)
              return res.json({
                  success: true,
                  message: "Successfully registered new user",
                  data: {
                    username: data.Username,
                    email: data.email,
                    UniversityRegistrationID: data.UniversityRegistrationID,
                  },
                });
              else return res.json(err);
            }
          );
        } else {
          return res.json({
            success: false,
            count: rows[0].count,
            message: "User already exists",
          });
        }
      }
    );
  });
};

exports.post_login2 = (req, res) => {
  const data = req.body;
  



  //verify credentials and generate web tokens
  pool.getConnection((err, connection) => {
    if (err) throw err;
    //check whether the user exists or not
    connection.query(
      "select count(*) as count from User where (InstitutionalEmail = ? or UniversityRegistrationID = ?)",
      [data.username, data.username],
      (err, rows) => {
        if (err) throw err;
        if (rows[0].count == 1) {
          //checking whether the password matched or not
          connection.query(
            "select * from User where (InstitutionalEmail = ? or UniversityRegistrationID = ?)",
            [data.username, data.username],
            async (err, rows) => {
              if (err) throw err;
              const password_matched = await bcrypt.compare(data.Password,rows[0].Password);
              if (password_matched) 
              {

                //generate web token
                try {
                  const tokendata = {
                    username: data.username,
                    usertype: rows[0].Usertype,
                  };
                const token =jwt.sign(tokendata, process.env.SECRET_KEY, {expiresIn: '30min'});
                return res.status(200).json({
                  success: true,
                  message: "login successful",
                  authtoken: token
                });
                } catch (error) {
                  console.log(error);
                }

              } 
              else 
              {
                return res.status(500).json({
                  success: false,
                  message: "password does not matched",
                });
              }
            }
          );
        } 
        else 
        {
          return res.status(404).json({
            success: false,
            message: "user does not exist",
          });
        }
      }
    );
    connection.release();
  });
};

exports.post_user_type_change = (req, res) => {
  const {email,new_user_type} = req.body;

  pool.getConnection((err, connection) => {
    if (err) throw err;
    connection.query("UPDATE User SET Usertype=? WHERE InstitutionalEmail = ? ",[new_user_type,email])
  })

  res.status(200).json({success: true, message: "user type changed"});
};
