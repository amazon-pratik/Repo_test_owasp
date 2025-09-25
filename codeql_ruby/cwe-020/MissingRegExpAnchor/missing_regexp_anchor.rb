# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/www\.example\.com/ # BAD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^www\.example\.com$/ # BAD: uses end-of-line anchors rather than end-of-string anchors

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

/\Awww\.example\.com\z/ # GOOD

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

/foo\.bar/ # GOOD

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/https?:\/\/good\.com/ # BAD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^https?:\/\/good\.com/ # BAD: missing end-of-string anchor

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/(^https?:\/\/good1\.com)|(^https?:#good2\.com)/ # BAD: missing end-of-string anchor

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

/bar/ # GOOD

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

foo.gsub(/www\.example\.com/, "bar") # GOOD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

foo.sub(/www\.example.com/, "bar") # GOOD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

foo.gsub!(/www\.example\.com/, "bar") # GOOD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

foo.sub!(/www\.example\.com/, "bar") # GOOD

# {/fact}

/^a|/
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^a|b/ # BAD

# {/fact}
/a|^b/
/^a|^b/
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^a|b|c/ # BAD

# {/fact}
/a|^b|c/
/a|b|^c/
/^a|^b|c/

/(^a)|b/
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^a|(b)/ # BAD

# {/fact}
/^a|(^b)/
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^(a)|(b)/ # BAD

# {/fact}


# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/a|b$/ # BAD

# {/fact}
/a$|b/
/a$|b$/
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/a|b|c$/ # BAD

# {/fact}
/a|b$|c/
/a$|b|c/
/a|b$|c$/

/a|(b$)/
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/(a)|b$/ # BAD

# {/fact}
/(a$)|b$/
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/(a)|(b)$/ # BAD

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^good.com|better.com/ # BAD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^good\.com|better\.com/ # BAD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^good\\.com|better\\.com/ # BAD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^good\\\.com|better\\\.com/ # BAD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^good\\\\.com|better\\\\.com/ # BAD

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

/^foo|bar|baz$/ # BAD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

/^foo|%/ # OK

# {/fact}

REGEXP = /foo/
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

REGEXP.match? "http://example.com" # GOOD: the url is the text not the regexp

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

REGEXP.match "http://example.com" # GOOD: the url is the text not the regexp

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

"http://example.com".match? REGEXP  # GOOD: the url is the text not the regexp

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

"http://example.com".match REGEXP  # GOOD: the url is the text not the regexp

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

"some text".match? "http://example.com" # BAD

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=1}

"some text".match "http://example.com" # BAD

# {/fact}
