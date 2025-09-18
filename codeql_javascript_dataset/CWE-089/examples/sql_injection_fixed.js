const mysql = require('mysql');

function getUserDataSafe(userId) {
    const connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'password',
        database: 'users'
    });
    
    // Safe parameterized query
    const query = 'SELECT * FROM users WHERE id = ?';
    connection.query(query, [userId], (error, results) => {
        if (error) throw error;
        console.log(results);
    });
}