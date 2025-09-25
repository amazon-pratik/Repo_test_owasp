require "httparty"

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

HTTParty.get("http://example.com/", verify: false)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

HTTParty.get("http://example.com/", verify_peer: false)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

HTTParty.get("http://example.com/", { verify_peer: false })
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

HTTParty.post("http://example.com/", body: "some_data", verify: false)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

HTTParty.post("http://example.com/", { body: "some_data", verify: false })
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

HTTParty.get("http://example.com/", verify: true)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

HTTParty.get("http://example.com/", verify_peer: true)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

HTTParty.post("http://example.com/", body: "some_data")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

HTTParty.post("http://example.com/", body: "some_data", verify: true)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

HTTParty.post("http://example.com/", { body: "some_data" })
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

HTTParty.post("http://example.com/", { body: "some_data", verify: true })
# {/fact}