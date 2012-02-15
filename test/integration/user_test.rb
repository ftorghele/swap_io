require 'integration_test_helper'

class UserTest < ActionDispatch::IntegrationTest

  should 'show user profile action' do
    user = Factory.create(:user, :description => "blabla")
    course = Factory.create(:course, :user => user)
    visit "/"
    click_on "#{course.user.first_name} #{course.user.last_name}"

    assert page.has_selector?('img')
    assert page.has_content?(course.user.first_name)
    assert page.has_content?(course.user.last_name)
    assert page.has_content?(course.user.description)
  end

end
