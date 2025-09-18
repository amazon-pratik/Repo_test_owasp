// DOM-based XSS vulnerability
function displayUserInput() {
    const userInput = new URLSearchParams(window.location.search).get('input');
    document.getElementById('output').innerHTML = userInput; // Vulnerable
}

// Usage
displayUserInput();