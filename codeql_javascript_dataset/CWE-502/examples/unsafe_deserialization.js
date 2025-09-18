const express = require('express');
const app = express();

app.use(express.json());

app.post('/deserialize', (req, res) => {
    const serializedData = req.body.data;
    
    // Dangerous - deserializing untrusted data
    const obj = JSON.parse(serializedData);
    
    // If using libraries like node-serialize, this could be even more dangerous
    // const obj = require('node-serialize').unserialize(serializedData);
    
    res.json({ result: obj });
});