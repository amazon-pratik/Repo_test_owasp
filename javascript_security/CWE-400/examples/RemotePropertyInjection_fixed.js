//{fact rule=resource-leak@v1.0 defects=0}

var express = require('express');

var app = express();
var myObj = {}

app.get('/user/:id', function(req, res) {
	var prop = "$" + req.query.userControlled; // GOOD
	myObj[prop] = function() {};
	console.log("Request object " + myObj);
});

//{/fact}