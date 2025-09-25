require 'rails'

module App
  class Application < Rails::Application
    config.load_defaults 6.0

# {fact rule=insecure-file-permissions@v1.0 defects=0}

    # GOOD: strong cipher

    config.action_dispatch.encrypted_cookie_cipher = "aes-256-gcm"
# {/fact}

# {fact rule=insecure-file-permissions@v1.0 defects=0}

    # GOOD: strong cipher

    config.action_dispatch.encrypted_cookie_cipher = "ChaCha"
# {/fact}

# {fact rule=insecure-file-permissions@v1.0 defects=1}

    # BAD: weak block encryption algorithm

    config.action_dispatch.encrypted_cookie_cipher = "DES"
# {/fact}

# {fact rule=insecure-file-permissions@v1.0 defects=1}

    # BAD: weak block encryption mode

    config.action_dispatch.encrypted_cookie_cipher = "AES-256-ECB"
# {/fact}

# {fact rule=insecure-file-permissions@v1.0 defects=0}

    # GOOD

    config.action_dispatch.use_authenticated_cookie_encryption = true
# {/fact}

# {fact rule=insecure-file-permissions@v1.0 defects=1}

    # BAD: less secure block encryption mode

    config.action_dispatch.use_authenticated_cookie_encryption = false
# {/fact}

# {fact rule=insecure-file-permissions@v1.0 defects=0}

    # GOOD

    config.action_dispatch.cookies_same_site_protection = :lax
# {/fact}

# {fact rule=insecure-file-permissions@v1.0 defects=0}

    # GOOD

    config.action_dispatch.cookies_same_site_protection = "strict"
# {/fact}

# {fact rule=insecure-file-permissions@v1.0 defects=1}

    # BAD: disabling same-site protections for sending cookies

    config.action_dispatch.cookies_same_site_protection = :none
# {/fact}

# {fact rule=insecure-file-permissions@v1.0 defects=1}

    # BAD: not all browsers default to `lax` if unset

    config.action_dispatch.cookies_same_site_protection = nil
  end
# {/fact}
end
