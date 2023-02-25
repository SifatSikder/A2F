const express = require("express");
const router = express.Router();
const controller= require("../controllers/authenticationController");
const authenticator = require("../middlewares/authenticator");


// router.get("", controller.home);
// router.get("/register", controller.get_register);
// router.get("/login2", controller.get_login2);
// router.get("/dashboard", controller.get_dashboard);


router.post("/register", controller.post_register);
router.post("/login", controller.post_login2);
router.post("/admin/user_type_change",authenticator, controller.post_user_type_change);



module.exports =router;

