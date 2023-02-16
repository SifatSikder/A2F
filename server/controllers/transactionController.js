const pool = require("../../model/connection")


exports.get_cashin = (req, res) => {
    res.render("../views/phase-1/cashin");
  };