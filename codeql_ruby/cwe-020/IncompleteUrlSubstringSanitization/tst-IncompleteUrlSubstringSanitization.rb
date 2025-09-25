def test (x)
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("internal") != nil; # NOT OK, but not flagged

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("localhost") != nil; # NOT OK, but not flagged

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("secure.com") != nil; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("secure.net") != nil; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index(".secure.com") != nil; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("sub.secure.") != nil; # NOT OK, but not flagged

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index(".sub.secure.") != nil; # NOT OK, but not flagged

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("secure.com") === nil; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("secure.com") === 0; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("secure.com") >= 0; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.start_with?("https://secure.com"); # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.end_with?("secure.com"); # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.end_with?(".secure.com"); # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.start_with?("secure.com/"); # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("secure.com/") === 0; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.include?("secure.com"); # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("#") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index(":") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index(":/") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("://") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("//") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index(":443") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("/some/path/") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("some/path") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("/index.html") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index(":template:") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("https://secure.com") != nil; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("https://secure.com:443") != nil; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("https://secure.com/") != nil; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index(".cn") != nil; # NOT OK, but not flagged

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index(".jpg") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("index.html") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("index.js") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("index.php") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("index.css") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

    x.index("secure=true") != nil; # OK (query param)

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("&auth=") != nil; # OK (query param)

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index(getCurrentDomain()) != nil; # NOT OK, but not flagged

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index(location.origin) != nil; # NOT OK, but not flagged

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	x.index("tar.gz") + offset; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	x.index("tar.gz") - offset; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("https://example.internal") != nil; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.index("https://") != nil; # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.start_with?("https://example.internal"); # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index('https://example.internal.org') != 0; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index('https://example.internal.org') === 0; # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.end_with?("internal.com"); # NOT OK

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.start_with?("https://example.internal:80"); # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

	x.index("secure.com") != nil; # NOT OK

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	x.index("secure.com") === nil; # OK

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	!(x.index("secure.com") != nil); # OK

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

	!x.include?("secure.com"); # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

	if !x.include?("secure.com") # NOT OK

# {/fact}

	else
		doSomeThingWithTrustedURL(x);
    end
    
# {fact rule=cryptographic-key-generator@v1.0 defects=0}
    x.start_with?("https://secure.com/foo/bar"); # OK - a forward slash after the domain makes prefix checks safe.

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("https://secure.com/foo/bar") >= 0 # NOT OK - the url can be anywhere in the string.

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("https://secure.com") >= 0 # NOT OK

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

    x.index("https://secure.com/foo/bar-baz") >= 0 # NOT OK - the url can be anywhere in the string.

# {/fact}
end
