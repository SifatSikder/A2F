const mysql = require("mysql");
const pool = mysql.createPool({
  connectionLimit: 100,
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
}); // a cache of database connection so that we can reuse connections when future requests come in

exports.home = (req, res) => {
  res.render("home");
};

exports.view_register = (req, res) => {
  console.log('This is view',req.url);
  res.render("register",{ layout: false ,exists:false});
};

exports.register2 = (req, res) => {
  console.log(req.url);
  res.render("register2", { layout: false });
};

exports.register3 = (req, res) => {
  console.log(req.url);
  res.render("register3", { layout: false });
};

exports.register4 = (req, res) => {
  console.log(req.url);
  res.render("register4", { layout: false });
};

exports.register = (req, res) => {
  pool.getConnection((err, connection) => {
    if (err) throw err;
    const data = req.body;
    connection.query(
      "select count(*) as count from User where InstitutionalEmail = ?",
      [data.email],
      (err, rows) => {
        console.log(rows[0]);
        console.log(rows[0].count);
        if (rows[0].count<1) 
        {
            connection.query("INSERT INTO User SET Name = ?, InstitutionalEmail = ?, UniversityRegistrationID = ?, Password = ?,PhoneNumber = ?,bKashNumber = ?",[data.Username,data.email,data.UniversityRegistrationID,data.password,data.PhoneNumber,data.bKashNumber],
            (err,rows)=>{
                connection.release();
                if(!err)  res.redirect("/login2");
                else     res.send(err);
            })
        }
        else
        {
            console.log("code is here");
            console.log(req.url);
            const params = {count: rows[0].count ,message : "User already exists" };
            res.render("register",{ layout: false ,exists:true});

        }
      }
    );
  }); //connecting to the database
};

exports.login = (req, res) => {
  res.render("login",{ layout: false });
};

exports.login2 = (req, res) => {
  res.render("login2",{ layout: false });
};