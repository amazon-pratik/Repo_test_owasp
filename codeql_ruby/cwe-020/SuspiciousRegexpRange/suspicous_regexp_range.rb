# {fact rule=cryptographic-key-generator@v1.0 defects=1}

overlap1 = /^[0-93-5]$/ # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

overlap2 = /[A-ZA-z]/ # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

isEmpty = /^[z-a]$/ # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

isAscii = /^[\x00-\x7F]*$/ # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

printable = /[!-~]/ # OK - used to select most printable ASCII characters

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

codePoints = /[^\x21-\x7E]|[\[\](){}<>\/%]/ # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

NON_ALPHANUMERIC_REGEXP = /([^\#-~| |!])/ # OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

smallOverlap = /[0-9a-fA-f]/ # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

weirdRange = /[$-`]/ # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

keywordOperator = /[!\~\*\/%+-<>\^|=&]/ # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

notYoutube = /youtu\.be\/[a-z1-9.-_]+/ # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

numberToLetter = /[7-F]/ # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

overlapsWithClass1 = /[0-9\d]/ # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

overlapsWithClass2 = /[\w,.-?:*+]/ # NOT OK

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

escapes = /[\000-\037\047\134\177-\377]/n # OK - they are escapes

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

nested = /[a-z&&[^a-c]]/ # OK

# {/fact}

overlapsWithNothing = /[\w_%-.]/;