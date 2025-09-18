const express = require('express');
const csrf = require('csurf');
const app = express();

// Enable CSRF protection
const csrfProtection = csrf({ cookie: true });

app.use(express.urlencoded({ extended: true }));
app.use(csrfProtection);

// Protected endpoint with CSRF token validation
app.post('/transfer-money', (req, res) => {
    const { amount, toAccount } = req.body;
    
    // CSRF token is automatically validated by middleware
    transferMoney(req.user.id, toAccount, amount);
    
    res.json({ success: true, message: 'Transfer completed' });
});

// Provide CSRF token to client
app.get('/csrf-token', (req, res) => {
    res.json({ csrfToken: req.csrfToken() });
});