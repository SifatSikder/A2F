const express = require("express");
const router = express.Router();
const controller= require("../controllers/userController");

router.get("", controller.home);
router.get("/register2", controller.register2);
router.get("/register3", controller.register3);
router.get("/register4", controller.register4);


router.get("/register", controller.view_register);
router.post("/register", controller.register);

router.get("/login", controller.login);
router.get("/login2", controller.login2);

module.exports =router;