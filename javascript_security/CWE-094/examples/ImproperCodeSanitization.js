//{fact rule=code-injection@v1.0 defects=1}

function createObjectWrite() {
    const assignment = `obj[${JSON.stringify(key)}]=42`;
    return `(function(){${assignment}})` // NOT OK
}

//{/fact}