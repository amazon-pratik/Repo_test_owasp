//{fact rule=cross-site-scripting@v1.0 defects=1}

function setLanguageOptions() {
    var href = document.location.href,
        deflt = href.substring(href.indexOf("default=")+8);
    
    try {
        var parsed = unknownParseFunction(deflt); 
    } catch(e) {
        document.write("Had an error: " + e + ".");
    }
}

//{/fact}