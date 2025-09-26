//{fact rule=weak-random-number-generation@v1.0 defects=1}

const crypto = require('crypto');

const digits = [];
for (let i = 0; i < 10; i++) {
    digits.push(crypto.randomBytes(1)[0] % 10); // NOT OK
}

//{/fact}
