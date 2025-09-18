function calculateExpressionSafe(userInput) {
    // Use a safe expression evaluator or whitelist approach
    const allowedOperations = /^[0-9+\-*/().\s]+$/;
    
    if (!allowedOperations.test(userInput)) {
        throw new Error('Invalid expression');
    }
    
    // Use Function constructor with restricted scope (still risky, better to use a proper parser)
    try {
        const result = Function('"use strict"; return (' + userInput + ')')();
        return result;
    } catch (e) {
        throw new Error('Invalid expression');
    }
}