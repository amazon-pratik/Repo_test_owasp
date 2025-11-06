const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const { exec } = require('child_process');
const port = 3005;

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());


const sqlite3 = require('sqlite3').verbose();
// In-memory "database" to store comments
let comments = [];

// Middleware to parse JSON
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// {fact rule=hardcoded-credentials@v1.0 defects=0}
// Connect to SQLite database
const db = new sqlite3.Database('mydatabase', (err) => {
  if (err) {
    console.error('Error connecting to database:', err.message);
  } else {
    console.log('Connected to the SQLite database.');
  }
});
// {/fact}


// Vulnerable SQL Injection Endpoint
app.get('/login', (req, res) => {
  const username = req.query.user;

  // Vulnerable SQL query (user input directly concatenated)
  const query = `SELECT * FROM users WHERE username = '${username}'`;
  //console.log(query);

  db.get(query, (err, row) => {
    if (err) {
      res.status(500).send(`Database error.${err}`);
      return;
    }
    if (row) {
      res.send(`Welcome, ${row.username}!`);
    } else {
      res.send(`Invalid username or password.${row}`);
    }
  });
});
// Vulnerable XSS Endpoint
app.get('/xss', (req, res) => {
  const userInput = req.query.input;
  res.send(`<h1>User Input:</h1><p>${userInput}</p>`);
});
// {fact rule=os-command-injection@v1.0 defects=1}
// Vulnerable Command Injection Endpoint
app.get('/ping', (req, res) => {
  const target = req.query.target; // User input without validation

  // Vulnerable command: directly concatenating user input into a shell command
  exec(`ping -c 3 ${target}`, (error, stdout, stderr) => {
    if (error) {
      res.status(500).send(`Error: ${stderr}`);
      return;
    }
    res.send(`<pre>${stdout}</pre>`);
// {/fact}
  });
});
app.get('/', (req, res) => {
  const userInput = req.query.input;
  res.send('OK');
});
// Vulnerable endpoint to store comments
app.get('/comment', (req, res) => {
  const userInput = req.query.input;

  // Vulnerable eval usage (DO NOT USE IN PRODUCTION)
  // {fact rule=code-injection@v1.0 defects=1}
  eval(`var injectedComment = '${userInput}'`);
// {/fact}
  // Store the comment (without sanitization)
  comments.push(userInput);
  res.redirect('/');
});

// Start server
app.listen(port, () => {
  console.log(`Vulnerable app listening at http://localhost:${port}`);
});
