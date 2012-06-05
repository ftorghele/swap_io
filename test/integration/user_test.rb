require 'integration_test_helper'

class UserTest < ActionDispatch::IntegrationTest

  should 'show user profile action' do
    user = Factory.create(:user)
    course = Factory.build(:course, :user => user)
    course.categories << Factory.create(:category)
    course.save
    visit "/mitglied/#{user.id}"
    assert page.has_selector?('img')
    assert page.has_content?(user.first_name)
    assert page.has_content?(user.last_name)
  end

  should 'not be able to render email new action if not logged in' do
    user = Factory.create(:user)
    visit "/#{I18n.t('routes.users.as')}/#{user.id}"
    assert page.has_no_link?("email")
  end

end
