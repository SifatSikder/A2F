const pool = require("../../model/connection")

exports.home = (req, res) => {
  res.render("../views/phase-1/home");
};

exports.register2 = (req, res) => {
  console.log(req.url);
  res.render("../views/phase-1/register2", { layout: false });
};

exports.register3 = (req, res) => {
  console.log(req.url);
  res.render("../views/phase-1/register3", { layout: false });
};

exports.register4 = (req, res) => {
  console.log(req.url);
  res.render("../views/phase-1/register4", { layout: false });
};

exports.get_register = (req, res) => {
  console.log("This is view", req.url);
  res.render("../views/phase-1/register", { layout: false, exists: false });
};

exports.post_register = (req, res) => {
  pool.getConnection((err, connection) => {
    if (err) throw err;
    const data = req.body;
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
              if (!err) res.redirect("/login2");
              else res.send(err);
            }
          );
        } else {
          const params = {
            count: rows[0].count,
            message: "User already exists",
          };
          res.render("../views/phase-1/register", { layout: false, exists: true });
        }
      }
    );
  }); //connecting to the database
};

exports.get_login = (req, res) => {
  res.render("../views/phase-1/login", { layout: false });
};

exports.get_login2 = (req, res) => {
  res.render("../views/phase-1/login2", { layout: false });
};

exports.post_login2 = (req, res) => {
  const data = req.body;
  console.log(data);

  pool.getConnection((err, connection) => {
    if (err) throw err;
    connection.query(
      "select count(*) as count from User where (InstitutionalEmail = ? or UniversityRegistrationID = ?) and (Password = ?)",
      [data.username, data.username,data.Password],
      (err, rows) => {
        connection.release();
        if (err) throw err;
        if(rows[0].count==1)
        { 
          // res.render("login2", { layout: false, unsuccessful: false});
          // res.send("her")
          res.redirect("/dashboard");
        }
        else{
          res.render("../views/phase-1/login2", { layout: false, unsuccessful: true});
        }
      }
    );
  });

};

exports.get_dashboard = (req, res) => {
  res.render('../views/phase-2/dashboard', { layout: false });
};

