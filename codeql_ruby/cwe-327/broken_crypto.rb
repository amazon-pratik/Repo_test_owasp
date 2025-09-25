require 'openssl'

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: creating a cipher using a weak scheme

weak = OpenSSL::Cipher.new('des3')
weak.encrypt
weak.random_key
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: encrypting data using a weak cipher

weak.update('foo')
weak.final
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: creating a cipher using a weak block mode

weak = OpenSSL::Cipher::AES.new(128, 'ecb')
weak.encrypt
weak.random_key
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: encrypting data using a weak block mode

weak.update('foo')
weak.final
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

# GOOD: creating a cipher using a strong scheme

strong = OpenSSL::Cipher.new('blowfish')
strong.encrypt
strong.random_key
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

# GOOD: encrypting data using a strong cipher

strong.update('bar')
strong.final
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak block mode

OpenSSL::Cipher::AES.new(128, :ecb)
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

# GOOD: strong encryption algorithm

OpenSSL::Cipher::AES.new(128, 'cbc')
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

# GOOD: strong encryption algorithm

OpenSSL::Cipher::AES.new('128-cbc')
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

# GOOD: strong encryption algorithm

OpenSSL::Cipher::AES128.new
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak block mode

OpenSSL::Cipher::AES128.new 'ecb'
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

# GOOD: strong encryption algorithm

OpenSSL::Cipher::AES192.new
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak block mode

OpenSSL::Cipher::AES192.new 'ecb'
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

# GOOD: strong encryption algorithm

OpenSSL::Cipher::AES256.new
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak block mode

OpenSSL::Cipher::AES256.new 'ecb'
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

# GOOD: strong encryption algorithm

OpenSSL::Cipher::BF.new
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak block mode

OpenSSL::Cipher::BF.new 'ecb'
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

# GOOD: strong encryption algorithm

OpenSSL::Cipher::CAST5.new
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak block mode

OpenSSL::Cipher::CAST5.new 'ecb'
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak encryption algorithm

OpenSSL::Cipher::DES.new
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak encryption algorithm


OpenSSL::Cipher::DES.new 'cbc'
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

# GOOD: strong encryption algorithm

OpenSSL::Cipher::IDEA.new
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak block mode

OpenSSL::Cipher::IDEA.new 'ecb'
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak encryption algorithm

OpenSSL::Cipher::RC2.new
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak encryption algorithm

OpenSSL::Cipher::RC2.new 'ecb'
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak encryption algorithm

OpenSSL::Cipher::RC4.new
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak encryption algorithm

OpenSSL::Cipher::RC4.new '40'
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=1}

# BAD: weak encryption algorithm

OpenSSL::Cipher::RC4.new 'hmac-md5'
# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

Digest::MD5.hexdigest('foo') # OK: don't report hash algorithm even if it is weak

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

Digest::SHA256.hexdigest('foo') # GOOD: strong hash algorithm

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

Digest::MD5.base64digest('foo') # OK: don't report hash algorithm even if it is weak

# {/fact}

md5 = Digest::MD5.new
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

md5.digest 'message' # OK: don't report hash algorithm even if it is weak

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

md5.update 'message1' # # OK: don't report hash algorithm even if it is weak

# {/fact}
md5 << 'message2' # << is an alias for update

sha256 = Digest::SHA256.new
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

sha256.digest 'message' # GOOD: strong hash algorithm

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

Digest::MD5.bubblebabble 'message' # OK: don't report hash algorithm even if it is weak

# {/fact}

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

filemd5 = Digest::MD5.file 'testfile' # OK: don't report hash algorithm even if it is weak

# {/fact}
filemd5.hexdigest

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

Digest("MD5").hexdigest('foo') # OK: don't report hash algorithm even if it is weak

# {/fact}

sha1 = OpenSSL::Digest.new('SHA1')
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

sha1.digest 'message' # OK: don't report hash algorithm even if it is weak

# {/fact}
sha1 << 'message' # << is an alias for update

# {fact rule=cryptographic-key-generator@v1.0 defects=0}

OpenSSL::Digest.digest('SHA1', "abc") # OK: don't report hash algorithm even if it is weak

# {/fact}
# {fact rule=cryptographic-key-generator@v1.0 defects=0}

OpenSSL::Digest.digest('SHA3-512', "abc") # GOOD: strong hash algorithm
# {/fact}

