const { exec, spawn, fork } = require('child_process');

app.get('/ping', (req, res) => {
    const ip = req.query.ip;
// {fact rule=os-command-injection@v1.0 defects=1}
    exec(`ping ${ip}`, (err, stdout) => res.send(stdout)); // Vulnerable
});

app.get('/backup', (req, res) => {
    const folder = req.query.folder;
    spawn('tar', ['-czf', 'backup.tar.gz', folder]); // Vulnerable
});

app.get('/run-task', (req, res) => {
    const task = req.query.task;
    fork(task); // Vulnerable
// {/fact}
});

const childProcess = require('child_process');

app.get('/delete', (req, res) => {
    const file = req.query.file;
    // {fact rule=os-command-injection@v1.0 defects=1}
    childProcess.exec(`rm ${file}`, (err) => res.send('Deleted')); // Vulnerable
});
// {/fact}
app.get('/archive', (req, res) => {
    const dir = req.query.dir;
    require('child_process').spawn('zip', ['-r', 'archive.zip', dir]); // Vulnerable
});

app.get('/eval-code', (req, res) => {
    const code = req.query.code;
    // {fact rule=code-injection@v1.0 defects=1}
    eval(code); // Vulnerable
});
// {/fact}

app.get('/run-dynamic', (req, res) => {
    const code = req.query.code;
    // {fact rule=code-injection@v1.0 defects=1}
    const dynamicFunction = new Function(code);
    dynamicFunction(); // Vulnerable
});
// {/fact}

process.env.PATH = process.env.PATH + ':/malicious/path'; // Vulnerable

const { exec } = require('child_process');
exec('echo "Injected Command"'); // Vulnerable due to PATH manipulation

const { exec } = require('child_process');

app.get('/list-files', (req, res) => {
    const command = `ls ${req.query.path}`;
    exec(command, (err, stdout) => res.send(stdout)); // Vulnerable
});

app.get('/dynamic-import', (req, res) => {
    const moduleName = req.query.module;
    // {fact rule=code-injection@v1.0 defects=1}
    const importedModule = require(moduleName); // Vulnerable
    res.send(`Module: ${importedModule}`);
});
// {/fact}

const { exec } = require('child_process');

app.get('/execute-powershell', (req, res) => {
    const command = `powershell.exe -Command "${req.query.cmd}"`;
    // {fact rule=path-traversal@v1.0 defects=1}
    exec(command, (err, stdout) => res.send(stdout)); // Vulnerable
});
// {/fact}

app.get('/execute-bash', (req, res) => {
    const command = `bash -c "${req.query.script}"`;
    exec(command, (err, stdout) => res.send(stdout)); // Vulnerable
});
