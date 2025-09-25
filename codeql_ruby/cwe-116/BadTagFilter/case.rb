filters = [
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<script.*?>.*?<\/script>/i, # NOT OK - doesn't match newlines or `</script >`

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<script.*?>.*?<\/script>/im, # NOT OK - doesn't match `</script >`

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=0}

    /<script.*?>.*?<\/script[^>]*>/im, # OK

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=0}

    /<!--.*-->/im, # OK - we don't care regexps that only match comments

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=0}

    /<!--.*--!?>/im, # OK

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<!--.*--!?>/i, # NOT OK, does not match newlines

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<script.*?>(.|\s)*?<\/script[^>]*>/i, # NOT OK - doesn't match inside the script tag

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<script[^>]*?>.*?<\/script[^>]*>/i, # NOT OK - doesn't match newlines inside the content

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<script(\s|\w|=|")*?>.*?<\/script[^>]*>/im, # NOT OK - does not match single quotes for attribute values

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<script(\s|\w|=|')*?>.*?<\/script[^>]*>/im, # NOT OK - does not match double quotes for attribute values

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<script( |\n|\w|=|'|")*?>.*?<\/script[^>]*>/im, # NOT OK - does not match tabs between attributes

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<script.*?>.*?<\/script[^>]*>/m, # NOT OK - does not match uppercase SCRIPT tags

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<(script|SCRIPT).*?>.*?<\/(script|SCRIPT)[^>]*>/m, # NOT OK - does not match mixed case script tags

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<script[^>]*?>[\s\S]*?<\/script.*>/i, # NOT OK - doesn't match newlines in the end tag

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=0}

    /<script[^>]*?>[\s\S]*?<\/script[^>]*?>/i, # OK

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<script\b[^>]*>([\s\S]*?)<\/script>/gi, # NOT OK - too strict matching on the end tag

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<(?:!--([\S|\s]*?)-->)|([^\/\s>]+)[\S\s]*?>/, # NOT OK - doesn't match comments with the right capture groups

# {/fact}
# {fact rule=autoescape-disabled@v1.0 defects=1}

    /<(?:(?:\/([^>]+)>)|(?:!--([\S|\s]*?)-->)|(?:([^\/\s>]+)((?:\s+[\w\-:.]+(?:\s*=\s*?(?:(?:"[^"]*")|(?:'[^']*')|[^\s"'\/>]+))?)*)[\S\s]*?(\/?)>))/, # NOT OK - capture groups

# {/fact}
]

doFilters(filters)