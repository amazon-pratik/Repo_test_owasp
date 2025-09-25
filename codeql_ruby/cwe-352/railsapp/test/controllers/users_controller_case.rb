require "test_helper"

class UsersControllerTest < ActiveSupport::TestCase
  setup do
# {fact rule=coral-csrf-rule@v1.0 defects=0}
    # GOOD: disabling CSRF protection in tests should not be flagged
    config.action_controller.allow_forgery_protection = false
# {/fact}
  end
end
