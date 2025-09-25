Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

# {fact rule=coral-csrf-rule@v1.0 defects=1}

  # BAD: Disabling forgery protection may open the application to CSRF attacks

  config.action_controller.allow_forgery_protection = false
# {/fact}
end
