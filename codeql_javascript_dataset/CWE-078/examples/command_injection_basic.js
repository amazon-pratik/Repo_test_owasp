const { exec } = require('child_process');

function processFile(filename) {
    // Vulnerable to command injection
    exec(`cat ${filename}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`Error: ${error}`);
            return;
        }
        console.log(stdout);
    });
}

// Dangerous usage: processFile("file.txt; rm -rf /");