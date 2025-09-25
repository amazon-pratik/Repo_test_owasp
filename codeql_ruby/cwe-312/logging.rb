stdout_logger = Logger.new STDOUT

password = "043697b96909e03ca907599d6420555f"

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.info password
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.debug password

# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.error password

# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext


stdout_logger.fatal password
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.unknown password
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.warn password
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.add Logger::WARN, password
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.add Logger::WARN, "message", password
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.log Logger::WARN, password
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger << "pw: #{password}"
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: sensitive data in the progname will taint subsequent logging calls

stdout_logger.progname = password
# {/ex-fact}

hsh1 = { password: "aec5058e61f7f122998b1a30ee2c66b6" }
hsh2 = {}
# {ex-fact rule=insecure-connection@v1.0 defects=0}

# GOOD: no backwards flow

stdout_logger.info hsh2[:password]
hsh2[:password] = "beeda625d7306b45784d91ea0336e201"
hsh3 = hsh2
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.info hsh1[:password]
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.info hsh2[:password]
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password logged as plaintext

stdout_logger.info hsh3[:password]

# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=0}

# GOOD: not a password

stdout_logger.info hsh1[:foo]
# {/ex-fact}

password_masked_sub = "ca497451f5e883662fb1a37bc9ec7838"
password_masked_sub_ex = "ca497451f5e883662fb1a37bc9ec7838"
password_masked_gsub = "a7e3747b19930d4f4b8181047194832f"
password_masked_gsub_ex = "a7e3747b19930d4f4b8181047194832f"
password_masked_sub = password_masked_sub.sub(/.+/, "[password]")
password_masked_sub_ex.sub!(/.+/, "[password]")
password_masked_gsub = password_masked_gsub.gsub(/./, "*")
password_masked_gsub_ex.gsub!(/./, "*")

# {ex-fact rule=insecure-connection@v1.0 defects=0}

# GOOD: password is effectively masked before logging

stdout_logger.info password_masked_sub
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=0}

# GOOD: password is effectively masked before logging

stdout_logger.info password_masked_gsub

# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=0}

# GOOD: password is effectively masked before logging

stdout_logger.info password_masked_sub_ex

# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=0}

# GOOD: password is effectively masked before logging

stdout_logger.info password_masked_gsub_ex
# {/ex-fact}

password_masked_ineffective_sub = "ca497451f5e883662fb1a37bc9ec7838"
password_masked_ineffective_sub_ex = "ca497451f5e883662fb1a37bc9ec7838"
password_masked_ineffective_gsub = "a7e3747b19930d4f4b8181047194832f"
password_masked_ineffective_gsub_ex = "a7e3747b19930d4f4b8181047194832f"
password_masked_ineffective_sub = password_masked_ineffective_sub.sub(/./, "[password]")
password_masked_ineffective_sub_ex.sub!(/./, "[password]")
password_masked_ineffective_gsub = password_masked_ineffective_gsub.gsub(/[A-Z]/, "*")
password_masked_ineffective_gsub_ex.gsub!(/[A-Z]/, "*")

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password masked ineffectively

stdout_logger.info password_masked_ineffective_sub
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password masked ineffectively

stdout_logger.info password_masked_ineffective_gsub
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password masked ineffectively

stdout_logger.info password_masked_ineffective_sub_ex
# {/ex-fact}

# {ex-fact rule=insecure-connection@v1.0 defects=1}

# BAD: password masked ineffectively

stdout_logger.info password_masked_ineffective_gsub_ex
# {/ex-fact}

def foo(password, logger)
# {ex-fact rule=insecure-connection@v1.0 defects=1}

  # BAD: password logged as plaintext

  logger.info password
end
# {/ex-fact}

password_arg = "65f2950df2f0e2c38d7ba2ccca767291"
foo(password_arg, stdout_logger)
foo("65f2950df2f0e2c38d7ba2ccca767292", stdout_logger)

def redact(password)
  "***"
end

password_r1 = redact("65f2950df2f0e2c38d7ba2ccca767291")
password_r2 = password_r1
# {ex-fact rule=insecure-connection@v1.0 defects=0}

# GOOD: password_r2 has been redacted

stdout_logger.info password_r2
# {/ex-fact}
