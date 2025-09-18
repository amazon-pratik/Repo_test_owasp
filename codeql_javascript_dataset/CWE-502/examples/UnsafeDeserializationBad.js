//{fact rule=untrusted-deserialization@v1.0 defects=1}

const app = require("express")(),
  jsyaml = require("js-yaml");

app.get("load", function(req, res) {
  let data = jsyaml.load(req.params.data);
  // ...
});


//{/fact}