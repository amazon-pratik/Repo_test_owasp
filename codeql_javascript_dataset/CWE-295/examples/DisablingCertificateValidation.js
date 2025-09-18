//{fact rule=improper-certificate-validation@v1.0 defects=1}

let https = require("https");

https.request(
  {
    hostname: "secure.my-online-bank.com",
    port: 443,
    method: "POST",
    path: "send-confidential-information",
    rejectUnauthorized: false // BAD
  },
  response => {
    // ... communicate with secure.my-online-bank.com
  }
);


//{/fact}