/**
 * 🚨 VULNERABLE CODE - FOR GHAS DEMO PURPOSES ONLY
 * This file contains intentionally insecure code patterns to trigger GHAS alerts
 * DO NOT USE IN PRODUCTION!
 */

const express = require('express');
const fs = require('fs');
const { exec } = require('child_process');
const mysql = require('mysql'); // This will also show as missing dependency

const app = express();

// 🚨 SQL Injection Vulnerability
function getUserData(userId) {
    const connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        // {fact rule=hardcoded-credentials@v1.0 defects=1}
        password: 'password123', // Hard-coded password
        // {/fact}
        database: 'robots'
    });

    // VULNERABLE: SQL injection - user input directly concatenated
    const query = `SELECT * FROM users WHERE id = ${userId}`;

    connection.query(query, (error, results) => {
        if (error) {
            console.log('Database error:', error);
        }
        return results;
    });
}

// {fact rule=os-command-injection@v1.0 defects=1}
// 🚨 Command Injection Vulnerability
app.get('/api/robot/ping/:host', (req, res) => {
    const host = req.params.host;

    // VULNERABLE: Command injection - user input directly passed to shell
    exec(`ping -c 1 ${host}`, (error, stdout, stderr) => {
        if (error) {
            return res.status(500).json({ error: error.message });
        }
        res.json({ result: stdout });
    });
// {/fact}
});

// 🚨 Path Traversal Vulnerability
app.get('/api/files/:filename', (req, res) => {
    const filename = req.params.filename;

    // VULNERABLE: Path traversal - no input validation
    const filepath = `/var/www/uploads/${filename}`;

    fs.readFile(filepath, 'utf8', (err, data) => {
        if (err) {
            return res.status(404).json({ error: 'File not found' });
        }
        res.send(data);
    });
});

// 🚨 XSS Vulnerability
app.get('/api/search', (req, res) => {
    const query = req.query.q;

    // VULNERABLE: XSS - user input directly rendered without escaping
    const html = `
        <html>
            <body>
                <h1>Search Results for: ${query}</h1>
                <p>No results found for your search.</p>
            </body>
        </html>
    `;

    res.send(html);
});

// 🚨 Insecure Random Number Generation
function generateSessionToken() {
    // VULNERABLE: Using Math.random() for security-sensitive operations
    return Math.random().toString(36).substring(2, 15) +
           Math.random().toString(36).substring(2, 15);
}

// 🚨 Hardcoded Secrets
const config = {
    // {fact rule=hardcoded-credentials@v1.0 defects=1}
    apiKey: 'sk-1234567890abcdef', // Hard-coded API key
    // {/fact}
    // {fact rule=hardcoded-credentials@v1.0 defects=1}
    dbPassword: 'SuperSecret123!', // Hard-coded database password
    // {/fact}
    jwtSecret: 'my-super-secret-jwt-key', // Hard-coded JWT secret
    // {/fact}
// {fact rule=hardcoded-credentials@v1.0 defects=1}
    awsAccessKey: 'AKIAIOSFODNN7EXAMPLE', // Hard-coded AWS key
    // {/fact}

    // {fact rule=hardcoded-credentials@v1.0 defects=1}
    awsSecretKey: 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
    // {/fact}

};

// 🚨 Weak Cryptography
const crypto = require('crypto');

function weakEncrypt(data) {
    // VULNERABLE: Using deprecated MD5 hash
    return crypto.createHash('md5').update(data).digest('hex');
}

// 🚨 Insecure Deserialization
app.post('/api/robot/config', (req, res) => {
    const configData = req.body.config;

    // VULNERABLE: Deserializing untrusted data
    try {
        // {fact rule=code-injection@v1.0 defects=1}
        const config = eval(`(${configData})`); // Using eval() is dangerous!
        res.json({ message: 'Configuration updated', config });
    } catch (error) {
        res.status(400).json({ error: 'Invalid configuration' });
    }
});

// 🚨 Information Disclosure
app.get('/api/debug/error', (req, res) => {
    try {
        // Simulate an error
        throw new Error('Database connection failed: mysql://root:password123@localhost:3306/robots');
    } catch (error) {
        // VULNERABLE: Exposing sensitive information in error messages
        res.status(500).json({
            error: error.message,
            stack: error.stack,
            env: process.env // Exposing environment variables
        });
    }
});

// 🚨 Prototype Pollution
function merge(target, source) {
    for (let key in source) {
        if (typeof source[key] === 'object') {
            target[key] = merge(target[key] || {}, source[key]);
        } else {
            target[key] = source[key];
        }
    }
    return target;
}

module.exports = {
    getUserData,
    generateSessionToken,
    weakEncrypt,
    merge,
    config
};
