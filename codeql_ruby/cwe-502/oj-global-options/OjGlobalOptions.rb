require "oj"

class UsersController < ActionController::Base
# {fact rule=object-input-stream-insecure-deserialization@v1.0 defects=0}

  # GOOD - Oj.load is safe when any mode other than :object is set globally

  def route0
    json_data = params[:key]
    object = Oj.load json_data
  end
# {/fact}

# {fact rule=object-input-stream-insecure-deserialization@v1.0 defects=1}

  # BAD - the safe mode set globally is overridden with an unsafe mode passed as

  # a call argument
  def route1
    json_data = params[:key]
    object = Oj.load json_data, mode: :object
  end
end
# {/fact}
