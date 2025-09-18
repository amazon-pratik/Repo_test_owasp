//{fact rule=untrusted-deserialization@v1.0 defects=0}

const app = require("express")(),
  jsyaml = require("js-yaml");

app.get("load", function(req, res) {
  let data = jsyaml.safeLoad(req.params.data);
  // ...
});


//{/fact}