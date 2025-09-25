class UsersController < ApplicationController

# {fact rule=coral-csrf-rule@v1.0 defects=1}
  # BAD: Disabling forgery protection may open the application to CSRF attacks

  skip_before_action :verify_authenticity_token

  def change_email
    user = current_user
    user.email = params[:new_email]
    user.save!
  end
# {/fact}
end
