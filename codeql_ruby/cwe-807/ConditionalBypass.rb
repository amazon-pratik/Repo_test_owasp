class FooController < ActionController::Base
  def bad_handler1
    check = params[:check]
    name = params[:name]

# {fact rule=untrusted-data-in-decision@v1.0 defects=1}
    if check
      # BAD
      authenticate_user! name
    end
  end
# {/fact}

  def bad_handler2
# {fact rule=untrusted-data-in-decision@v1.0 defects=1}
    # BAD
    login if params[:login]
    do_something_else
  end
# {/fact}

  def bad_handler3
# {fact rule=untrusted-data-in-decision@v1.0 defects=1}
    # BAD. Not detected: its the last statement in the method, so it doesn't
    # match the heuristic for an action.
    login if params[:login]
  end
# {/fact}

  def bad_handler4
    p = (params[:name] == "foo")
# {fact rule=untrusted-data-in-decision@v1.0 defects=1}
    # BAD

    if p
      verify!
    end
  end
# {/fact}

  def good_handler
    name = params[:name]
    # Call to a sensitive action, but the guard is not derived from user input.
    if should_auth_user?
      authenticate_user! name
    end
  end
end
