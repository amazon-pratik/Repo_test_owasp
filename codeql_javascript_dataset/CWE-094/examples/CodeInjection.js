//{fact rule=code-injection@v1.0 defects=0}

eval(document.location.href.substring(document.location.href.indexOf("default=")+8))

//{/fact}