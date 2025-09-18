const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();

app.get('/file/:filename', (req, res) => {
    const filename = req.params.filename;
    
    // Sanitize and validate path
    const safePath = path.resolve('./uploads', path.basename(filename));
    
    // Ensure the resolved path is within uploads directory
    if (!safePath.startsWith(path.resolve('./uploads'))) {
        res.status(403).send('Access denied');
        return;
    }
    
    fs.readFile(safePath, 'utf8', (err, data) => {
        if (err) {
            res.status(404).send('File not found');
            return;
        }
        res.send(data);
    });
});