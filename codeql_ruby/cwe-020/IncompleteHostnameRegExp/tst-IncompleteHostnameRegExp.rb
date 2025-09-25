def foo
# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	/^http:\/\/example.com/; # OK
# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^http:\/\/test.example.com/; # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	/^http:\/\/test\.example.com/; # OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^http:\/\/test.example.net/; # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^http:\/\/test.(example-a|example-b).com/; # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^http:\/\/(.+).example.com\//; # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	/^http:\/\/(\.+)\.example.com/; # OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^http:\/\/(?:.+)\.test\.example.com\//; # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	/^http:\/\/test.example.com\/(?:.*)/; # OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	Regexp.new("^http://test.example.com"); # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	if (s.match("^http://test.example.com")); end # NOT OK
# {/fact}


# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	Regexp.new(id(id(id("^http://test.example.com")))); # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	Regexp.new(`test.example.com$`); # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	hostname = '^test.example.com'; # NOT OK
# {/fact}

	Regexp.new("#{hostname}$");

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	domain = { hostname: 'test.example.com$' }; # NOT OK
# {/fact}

	Regexp.new(domain[:hostname]);

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	convert1({ hostname: 'test.example.com$' }); # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	domains = [ { hostname: 'test.example.com$' } ];  # NOT OK - but not flagged due to limitations of TypeTracking.
# {/fact}


	domains.map{ |d| convert2(d) };

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^(.+\.(?:example-a|example-b)\.com)\//; # NOT OK

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^(https?:)?\/\/((service|www).)?example.com(?=$|\/)/; # NOT OK

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^(http|https):\/\/www.example.com\/p\/f\//; # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^(http:\/\/sub.example.com\/)/i; # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^https?:\/\/api.example.com/; # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	Regexp.new('^http://localhost:8000|' + "^https?://.+\\.example\\.com/"); # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	Regexp.new("^http[s]?:\/\/?sub1\\.sub2\\.example\\.com\/f\/(.+)"); # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	/^https:\/\/[a-z]*.example.com$/; # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	Regexp.compile('^protos?://(localhost|.+.example.net|.+.example-a.com|.+.example-b.com|.+.example.internal)'); # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	/^(example.dev|example.com)/; # OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	Regexp.new('^http://localhost:8000|' + "^https?://.+.example\\.com/"); # NOT OK
# {/fact}

	primary = 'example.com$';
# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	Regexp.new('test.' + primary); # NOT OK, but not detected

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	Regexp.new('test.' + 'example.com$'); # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}
	Regexp.new('^http://test\.example.com'); # NOT OK
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	/^http:\/\/(..|...)\.example\.com\/index\.html/; # OK, wildcards are intentional
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	/^http:\/\/.\.example\.com\/index\.html/; # OK, the wildcard is intentional
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}
	/^(foo.example\.com|whatever)$/; # kinda OK - one disjunction doesn't even look like a hostname
# {/fact}
end

def id(e); return e; end
def convert1(domain)
	return Regexp.new(domain[:hostname]);
end
def convert2(domain)
	return Regexp.new(domain[:hostname]);
end
