require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Railsapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

# {fact rule=coral-csrf-rule@v1.0 defects=1}
    # BAD: Disabling forgery protection may open the application to CSRF attacks

    config.action_controller.allow_forgery_protection = false
# {/fact}
  end
end
