const express = require('express');
const Joi = require('joi');
const app = express();

app.use(express.json());

// Define expected schema
const dataSchema = Joi.object({
    name: Joi.string().max(100).required(),
    age: Joi.number().integer().min(0).max(150),
    email: Joi.string().email()
});

app.post('/deserialize', (req, res) => {
    const serializedData = req.body.data;
    
    try {
        const obj = JSON.parse(serializedData);
        
        // Validate against schema
        const { error, value } = dataSchema.validate(obj);
        
        if (error) {
            res.status(400).json({ error: 'Invalid data format' });
            return;
        }
        
        res.json({ result: value });
    } catch (parseError) {
        res.status(400).json({ error: 'Invalid JSON' });
    }
});