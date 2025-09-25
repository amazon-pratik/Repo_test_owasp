require "excon"

def method1
# {fact rule=improper-certificate-validation@v1.0 defects=1}

  # BAD

  Excon.defaults[:ssl_verify_peer] = false
  Excon.get("http://example.com/")
end
# {/fact}

def method2
# {fact rule=improper-certificate-validation@v1.0 defects=1}

  # BAD


  Excon.ssl_verify_peer = false
  Excon.get("http://example.com/")
end
# {/fact}

def method3(secure)
# {fact rule=improper-certificate-validation@v1.0 defects=1}

  # BAD

  Excon.defaults[:ssl_verify_peer] = (secure ? true : false)
  Excon.get("http://example.com/")
end
# {/fact}

def method4
# {fact rule=improper-certificate-validation@v1.0 defects=1}

  # BAD

  conn = Excon::Connection.new("http://example.com/", ssl_verify_peer: false)
  conn.get
end
# {/fact}

def method5
# {fact rule=improper-certificate-validation@v1.0 defects=1}

  # BAD

  Excon.ssl_verify_peer = true
  Excon.new("http://example.com/", ssl_verify_peer: false).get
end
# {/fact}

def method6
# {fact rule=improper-certificate-validation@v1.0 defects=0}

  # GOOD

  Excon.defaults[:ssl_verify_peer] = true
  Excon.get("http://example.com/")
end
# {/fact}

def method7
# {fact rule=improper-certificate-validation@v1.0 defects=0}

  # GOOD

  Excon.ssl_verify_peer = true
  Excon.get("http://example.com/")
end
# {/fact}

def method8
# {fact rule=improper-certificate-validation@v1.0 defects=0}

  # GOOD

  Excon.defaults[:ssl_verify_peer] = false
  Excon.new("http://example.com/", ssl_verify_peer: true)
end
# {/fact}

# Regression test for excon

class Excon
  def self.new(params)
    Excon::Connection.new(params)
  end
end

def method9
# {fact rule=improper-certificate-validation@v1.0 defects=0}

  # GOOD: connection is not used

  Excon.new("foo", ssl_verify_peer: false)
end
# {/fact}

def method10
# {fact rule=improper-certificate-validation@v1.0 defects=0}

  # GOOD

  connection = Excon.new("foo")
  connection.get("bar")
end
# {/fact}