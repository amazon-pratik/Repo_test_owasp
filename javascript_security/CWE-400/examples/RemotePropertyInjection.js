//{fact rule=insecure-object-attribute-modification@v1.0 defects=1}

var express = require('express');

var app = express();
var myObj = {}

app.get('/user/:id', function(req, res) {
	var prop = req.query.userControlled; // BAD
	myObj[prop] = function() {};
	console.log("Request object " + myObj);
});

//{/fact}
