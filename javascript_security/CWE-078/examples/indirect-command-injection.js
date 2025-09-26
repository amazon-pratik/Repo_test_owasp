//{fact rule=os-command-injection@v1.0 defects=1}

var cp = require("child_process");

const args = process.argv.slice(2);
const script = path.join(__dirname, 'bin', 'main.js');
cp.execSync(`node ${script} ${args.join(' ')}"`); // BAD


//{/fact}