Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

# {fact rule=coral-csrf-rule@v1.0 defects=0}
  # GOOD: disabling CSRF protection in the development environment should not be flagged
  config.action_controller.allow_forgery_protection = false
# {/fact}
end
