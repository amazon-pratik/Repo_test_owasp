const mysql = require('mysql');

function getUserData(userId) {
    const connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'password',
        database: 'users'
    });
    
    // Vulnerable to SQL injection
    const query = `SELECT * FROM users WHERE id = ${userId}`;
    connection.query(query, (error, results) => {
        if (error) throw error;
        console.log(results);
    });
}