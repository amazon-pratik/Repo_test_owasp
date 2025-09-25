require "rest-client"

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

resource = RestClient::Resource.new("https://example.com", verify_ssl: OpenSSL::SSL::VERIFY_NONE)
response = resource.get
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

resource = RestClient::Resource.new("https://example.com", { verify_ssl: OpenSSL::SSL::VERIFY_NONE })
response = resource.get
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

options = { verify_ssl: OpenSSL::SSL::VERIFY_NONE }
resource = RestClient::Resource.new("https://example.com", options)
response = resource.get
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

value = OpenSSL::SSL::VERIFY_NONE
resource = RestClient::Resource.new("https://example.com", verify_ssl: value)
response = resource.get
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

RestClient.get("https://example.com")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

resource = RestClient::Resource.new("https://example.com")
response = resource.get
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

resource = RestClient::Resource.new("https://example.com", verify_ssl: OpenSSL::SSL::VERIFY_PEER)
response = resource.get
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

resource = RestClient::Resource.new("https://example.com", { verify_ssl: OpenSSL::SSL::VERIFY_PEER })
response = resource.get
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

options = { verify_ssl: OpenSSL::SSL::VERIFY_PEER }
resource = RestClient::Resource.new("https://example.com", options)
response = resource.get
# {/fact}