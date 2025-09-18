//{fact rule=sensitive-information-leak@v1.0 defects=1}

var express = require('express');

var app = express();

app.use('/node_modules', express.static(path.resolve(__dirname, '../node_modules')));

//{/fact}