//{fact rule=resource-leak@v1.0 defects=1}

var http = require("http"),
    url = require("url");

var server = http.createServer(function(req, res) {
	var delay = parseInt(url.parse(req.url, true).query.delay);

	setTimeout(f, delay); // BAD

});


//{/fact}
