const express = require('express');
const url = require('url');
const app = express();

const ALLOWED_DOMAINS = ['example.com', 'subdomain.example.com'];

app.get('/redirect', (req, res) => {
    const redirectUrl = req.query.url;
    
    try {
        const parsedUrl = new URL(redirectUrl);
        
        // Only allow redirects to whitelisted domains
        if (!ALLOWED_DOMAINS.includes(parsedUrl.hostname)) {
            res.status(400).send('Invalid redirect URL');
            return;
        }
        
        res.redirect(redirectUrl);
    } catch (error) {
        res.status(400).send('Invalid URL format');
    }
});