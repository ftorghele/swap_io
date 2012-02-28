require 'integration_test_helper'

class UserTest < ActionDispatch::IntegrationTest

  should 'show user profile action' do
    user = Factory.create(:user, :description => "blabla")
    course = Factory.create(:course, :user => user)
    visit "/"
flunk "YOu are fucked"
    click_on I18n.t('app.course_link')
    click_on "#{course.user.first_name} #{course.user.last_name}"
    assert page.has_selector?('img')
    assert page.has_content?(course.user.first_name)
    assert page.has_content?(course.user.last_name)
    assert page.has_content?(course.user.description)
  end

  should 'be able to create skills' do
    visit "/"
    login_as
    click_on I18n.t('user.edit.title')
    click_on I18n.t('user.edit.tabs.about')
    assert page.has_content?(I18n.t('helpers.label.user.skills'))
    assert page.has_content?(I18n.t('helpers.label.user.description'))
    assert page.has_content?(I18n.t('helpers.label.user.image'))
  end

end
