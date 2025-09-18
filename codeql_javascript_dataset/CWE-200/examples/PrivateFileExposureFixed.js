//{fact rule=sensitive-information-leak@v1.0 defects=0}

var express = require('express');

var app = express();

app.use("jquery", express.static('./node_modules/jquery/dist'));
app.use("bootstrap", express.static('./node_modules/bootstrap/dist'));

//{/fact}