const express = require("express");
const router = express.Router();
const controller= require("../controllers/transactionController");

router.get("/cashin", controller.get_cashin);

module.exports =router;