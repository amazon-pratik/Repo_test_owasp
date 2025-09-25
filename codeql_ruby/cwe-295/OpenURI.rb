require "open-uri"

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

Kernel.open("https://example.com", ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

Kernel.open("https://example.com", { ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE })
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

options = { ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }
Kernel.open("https://example.com", options)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

URI.parse("https://example.com").open(ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

URI.parse("https://example.com").open({ ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE })
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=1}

# BAD

options = { ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }
URI.parse("https://example.com").open(options)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

Kernel.open("https://example.com")
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

Kernel.open("https://example.com", ssl_verify_mode: OpenSSL::SSL::VERIFY_PEER)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

Kernel.open("https://example.com", { ssl_verify_mode: OpenSSL::SSL::VERIFY_PEER })
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

options = { ssl_verify_mode: OpenSSL::SSL::VERIFY_PEER }
Kernel.open("https://example.com", options)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

URI.parse("https://example.com").open
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

URI.parse("https://example.com").open(ssl_verify_mode: OpenSSL::SSL::VERIFY_PEER)
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

URI.parse("https://example.com").open({ ssl_verify_mode: OpenSSL::SSL::VERIFY_PEER })
# {/fact}

# {fact rule=improper-certificate-validation@v1.0 defects=0}

# GOOD

options = { ssl_verify_mode: OpenSSL::SSL::VERIFY_PEER }
URI.parse("https://example.com").open(options)
# {/fact}
