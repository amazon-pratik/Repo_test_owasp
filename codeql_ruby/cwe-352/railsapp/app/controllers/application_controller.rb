class ApplicationController < ActionController::Base

# {fact rule=coral-csrf-rule@v1.0 defects=1}

  # BAD: `protect_from_forgery` without `with: :exception` can expose an

  # application to CSRF attacks in some circumstances
  protect_from_forgery

  before_action authz_guard
# {/fact}
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authz_guard
    render(plain: "not logged in") unless logged_in?
  end
end
