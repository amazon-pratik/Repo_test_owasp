const express = require('express');
const app = express();

app.get('/redirect', (req, res) => {
    const redirectUrl = req.query.url;
    
    // Vulnerable - redirects to any URL
    res.redirect(redirectUrl);
});

// Dangerous: /redirect?url=http://malicious-site.com