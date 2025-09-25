require "typhoeus"

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

Typhoeus.get("https://www.example.com", ssl_verifypeer: false)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

post_options = { body: "some data", ssl_verifypeer: false }
Typhoeus.post("https://www.example.com", post_options)
# {/fact}


# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD


Typhoeus.get("https://www.example.com")
# {/fact}