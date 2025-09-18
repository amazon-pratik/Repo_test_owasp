function calculateExpression(userInput) {
    // Extremely dangerous - never do this
    const result = eval(userInput);
    return result;
}

// Dangerous usage: calculateExpression("require('fs').unlinkSync('/important/file')");