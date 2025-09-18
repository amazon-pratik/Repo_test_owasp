const { execFile } = require('child_process');
const path = require('path');

function processFileSafe(filename) {
    // Validate and sanitize filename
    const safePath = path.resolve('./uploads', path.basename(filename));
    
    // Use execFile instead of exec for better security
    execFile('cat', [safePath], (error, stdout, stderr) => {
        if (error) {
            console.error(`Error: ${error}`);
            return;
        }
        console.log(stdout);
    });
}