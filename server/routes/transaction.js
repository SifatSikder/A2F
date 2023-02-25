const express = require("express");
const router = express.Router();
const controller= require("../controllers/transactionController");
const authenticator = require("../middlewares/authenticator");

router.post("/cashin", authenticator,controller.cashin);
router.get("/cashin",controller.get_cashin3);


module.exports =router;