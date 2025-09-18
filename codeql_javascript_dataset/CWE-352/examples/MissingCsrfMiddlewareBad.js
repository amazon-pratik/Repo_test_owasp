//{fact rule=cross-site-request-forgery@v1.0 defects=1}

var app = require("express")(),
  cookieParser = require("cookie-parser"),
  passport = require("passport");

app.use(cookieParser());
app.use(passport.authorize({ session: true }));

app.post("/changeEmail", function(req, res) {
  let newEmail = req.cookies["newEmail"];
  // ...
});


//{/fact}