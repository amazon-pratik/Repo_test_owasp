//{fact rule=cryptographic-key-generator@v1.0 defects=0}

const cryptoRandomString = require('crypto-random-string');

const digits = cryptoRandomString({length: 10, type: 'numeric'});

//{/fact}
