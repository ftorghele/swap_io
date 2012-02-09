require "test_helper"
require "capybara/rails"

DatabaseCleaner.strategy = :truncation

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  def login_as
    user = Factory.create(:user)
    user.confirm!
    visit '/users/sign_in'
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
    click_on("Sign in")
  end

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
end
