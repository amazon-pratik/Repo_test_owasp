//{fact rule=os-command-injection@v1.0 defects=0}

var cp = require("child_process"),
  path = require("path");
function cleanupTemp() {
  let cmd = "rm",
    args = ["-rf", path.join(__dirname, "temp")];
  cp.execFileSync(cmd, args); // GOOD
}


//{/fact}