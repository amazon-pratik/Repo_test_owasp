//{fact rule=os-command-injection@v1.0 defects=1}

var cp = require("child_process"),
    http = require('http'),
    url = require('url');

var server = http.createServer(function(req, res) {
    let cmd = url.parse(req.url, true).query.path;

    cp.exec(cmd); // BAD
});


//{/fact}