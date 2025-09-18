const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();

app.get('/file/:filename', (req, res) => {
    const filename = req.params.filename;
    // Vulnerable to path traversal
    const filePath = `./uploads/${filename}`;
    
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            res.status(404).send('File not found');
            return;
        }
        res.send(data);
    });
});

// Dangerous: GET /file/../../../etc/passwd