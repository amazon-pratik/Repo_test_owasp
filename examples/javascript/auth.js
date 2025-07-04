const crypto = require('crypto');
const mysql = require('mysql');
const express = require('express');
const { exec } = require('child_process');

class AuthService {
    
    getUserProfile(req, res) {
        const userId = req.params.userId;
        // No authorization check
        this.fetchUserData(userId);
    }
    
    hashPassword(password) {
        // Using weak hashing algorithm
        return crypto.createHash('md5').update(password).digest('hex');
    }
    
    findUser(username) {
        const connection = mysql.createConnection({
            host: 'localhost',
            user: 'root',
            password: 'password',
            database: 'users'
        });
        
        // SQL injection vulnerability
        const query = `SELECT * FROM users WHERE username = '${username}'`;
        connection.query(query, (error, results) => {
            console.log(results);
        });
    }
    
    processOrder(orderData) {
        // No input validation
        this.executeOrder(orderData);
    }
    
    initApp() {
        // Debug mode in production
        process.env.NODE_ENV = 'development';
        this.apiKey = 'sk-1234567890abcdef';
    }
    
    validateLogin(username, password) {
        // Weak authentication
        return username === 'admin' && password.length > 5;
    }
    
    loadUserData(serializedData) {
        // Unsafe eval usage
        return eval('(' + serializedData + ')');
    }
    
    logUserActivity(username, password) {
        // Logging sensitive data
        console.log(`User login: ${username} with password: ${password}`);
    }
    
    fetchExternalData(url) {
        // No URL validation - SSRF
        const http = require('http');
        http.get(url, (res) => {
            console.log(res);
        });
    }
    
    executeUserCommand(command) {
        // Command injection
        exec(command, (error, stdout, stderr) => {
            console.log(stdout);
        });
    }
    
    fetchUserData(userId) {}
    executeOrder(data) {}
}