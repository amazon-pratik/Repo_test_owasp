class UsersController < ApplicationController

  def login_get_1
# {fact rule=get-request-with-sensitive-query@1.0 defects=1}

    foo = params[:password] # BAD: route handler uses GET query parameters to receive sensitive data

# {/fact}
    authenticate_user(params[:username], foo)
  end

  def login_get_2
# {fact rule=get-request-with-sensitive-query@1.0 defects=1}

    password = params[:foo] # BAD: route handler uses GET query parameters to receive sensitive data

# {/fact}
    authenticate_user(params[:username], password)
  end

  def login_get_3
# {fact rule=get-request-with-sensitive-query@1.0 defects=1}

    @password = params[:foo] # BAD: route handler uses GET query parameters to receive sensitive data

# {/fact}
    authenticate_user(params[:username], @password)
  end

  def login_post
# {fact rule=get-request-with-sensitive-query@1.0 defects=0}

    foo = params[:password] # GOOD: handler uses POST form parameters to receive sensitive data

# {/fact}
    authenticate_user(params[:username], foo)
  end

  def login_get_cookies
# {fact rule=get-request-with-sensitive-query@1.0 defects=0}

    foo = cookies[:password] # GOOD: data sourced from cookies rather than (plaintext) query params

# {/fact}
    authenticate_user(params[:username], foo)
  end

  private
  def authenticate_user(username, password)
    # ... authenticate the user here
  end
end
