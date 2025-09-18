//{fact rule=cross-site-scripting@v1.0 defects=0}

var express = require('express'),
    fs = require('fs'),
    escape = require('escape-html');

express().get('/list-directory', function(req, res) {
    fs.readdir('/public', function (error, fileNames) {
        var list = '<ul>';
        fileNames.forEach(fileName => {
            // GOOD: escaped `fileName` can not contain HTML elements
            list += '<li>' + escape(fileName) + '</li>';
        });
        list += '</ul>'
        res.send(list);
    });
});


//{/fact}