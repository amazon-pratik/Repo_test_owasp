//{fact rule=cross-site-request-forgery@v1.0 defects=0}

var app = require("express")(),
  cookieParser = require("cookie-parser"),
  passport = require("passport"),
  csrf = require("csurf");

app.use(cookieParser());
app.use(passport.authorize({ session: true }));
app.use(csrf({ cookie: true }));
app.post("/changeEmail", function(req, res) {
  let newEmail = req.cookies["newEmail"];
  // ...
});


//{/fact}