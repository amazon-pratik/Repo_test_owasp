require "httpclient"

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

client = HTTPClient.new
client.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
client.get("https://example.com")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

client = HTTPClient.new
client.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_PEER
client.get("https://example.com")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

client = HTTPClient.new
client.get("https://example.com")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

HTTPClient.get("https://example.com/")
# {/fact}