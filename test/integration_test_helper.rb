require "test_helper"
require "capybara/rails"

DatabaseCleaner.strategy = :truncation

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  def login_as user=nil
    user = user || Factory.create(:user)
    user.confirm!
    visit '/Hilfe'
    click_link(I18n.t('app.sign_in_link'))
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
    click_button(I18n.t('devise.sessions.submit'))
  end

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
end
