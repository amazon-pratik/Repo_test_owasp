require 'yaml'
class UsersController < ActionController::Base
  def example
# {fact rule=object-input-stream-insecure-deserialization@v1.0 defects=0}
    # safe
    Psych.load(params[:yaml_string])
    Psych.load_file(params[:yaml_file])
    Psych.parse_stream(params[:yaml_string])
    Psych.parse(params[:yaml_string])
    Psych.parse_file(params[:yaml_file])
# {/fact}

# {fact rule=object-input-stream-insecure-deserialization@v1.0 defects=1}
    # unsafe
    Psych.unsafe_load(params[:yaml_string])
# {/fact}

# {fact rule=object-input-stream-insecure-deserialization@v1.0 defects=1}
    Psych.unsafe_load_file(params[:yaml_file])
# {/fact}

# {fact rule=object-input-stream-insecure-deserialization@v1.0 defects=1}
    Psych.load_stream(params[:yaml_string])
# {/fact}

# {fact rule=object-input-stream-insecure-deserialization@v1.0 defects=1}
    parse_output = Psych.parse_stream(params[:yaml_string])
    parse_output.to_ruby
# {/fact}

# {fact rule=object-input-stream-insecure-deserialization@v1.0 defects=1}
    Psych.parse(params[:yaml_string]).to_ruby
# {/fact}

# {fact rule=object-input-stream-insecure-deserialization@v1.0 defects=1}
    Psych.parse_file(params[:yaml_file]).to_ruby
# {/fact}
  end
end


