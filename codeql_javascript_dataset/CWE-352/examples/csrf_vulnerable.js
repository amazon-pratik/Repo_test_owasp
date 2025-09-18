const express = require('express');
const app = express();

app.use(express.urlencoded({ extended: true }));

// Vulnerable endpoint - no CSRF protection
app.post('/transfer-money', (req, res) => {
    const { amount, toAccount } = req.body;
    
    // Process money transfer without CSRF token validation
    transferMoney(req.user.id, toAccount, amount);
    
    res.json({ success: true, message: 'Transfer completed' });
});

function transferMoney(fromUser, toAccount, amount) {
    // Transfer logic here
    console.log(`Transferring $${amount} from ${fromUser} to ${toAccount}`);
}