const express = require("express");
const router = express.Router();
const controller= require("../controllers/userController");

router.get("", controller.home);

//All subsidiaries....This will be deleted after we are done
router.get("/register2", controller.register2);
router.get("/register3", controller.register3);
router.get("/register4", controller.register4);
router.get("/login", controller.get_login);


router.get("/register", controller.get_register);
router.post("/register", controller.post_register);

router.get("/login2", controller.get_login2);
router.post("/login2", controller.post_login2);

router.get("/dashboard", controller.get_dashboard);

module.exports =router;