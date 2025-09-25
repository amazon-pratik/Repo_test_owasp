require "faraday"

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

connection = Faraday.new("http://example.com", ssl: { verify: false })
response = connection.get("/")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

connection = Faraday.new("http://example.com", ssl: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
response = connection.get("/")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

connection = Faraday.new("http://example.com")
response = connection.get("/")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

response = Faraday.get("http://example.com")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

connection = Faraday.new("http://example.com", ssl: { version: :TLSv1 })
response = connection.get("/")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

connection = Faraday.new("http://example.com", ssl: { verify: true })
response = connection.get("/")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

connection = Faraday.new("http://example.com", ssl: { verify_mode: OpenSSL::SSL::VERIFY_PEER })
response = connection.get("/")
# {/fact}

# -- example of passing verify as argument --

def verify_as_arg(host, path, arg)
# {fact rule=improper-certificate-validation@v1.0 defects=1}

    # BAD, due to the call below

    connection = Faraday.new(host, ssl: { verify: arg })
    response = connection.get(path)
end
# {/fact}
verify_as_arg("http://example.com", "/", false)


def verify_mode_as_arg(host, path, arg)
# {fact rule=improper-certificate-validation@v1.0 defects=1}

    # BAD, due to the call below

    connection = Faraday.new(host, ssl: { verify_mode: arg })
    response = connection.get(path)
end
# {/fact}
verify_mode_as_arg("http://example.com", "/", OpenSSL::SSL::VERIFY_NONE)
