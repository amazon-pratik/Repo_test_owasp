// DOM-based XSS fixed
function displayUserInputSafe() {
    const userInput = new URLSearchParams(window.location.search).get('input');
    document.getElementById('output').textContent = userInput; // Safe
}

// Usage
displayUserInputSafe();