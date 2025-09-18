//{fact rule=os-command-injection@v1.0 defects=1}

var child_process = require('child_process');

module.exports = function (name) {
    return child_process.execSync("cat " + name).toString();
};

//{/fact}