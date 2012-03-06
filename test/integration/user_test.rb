require 'integration_test_helper'

class UserTest < ActionDispatch::IntegrationTest

  should 'show user profile action' do
    user = Factory.create(:user, :description => "blabla")
    course = Factory.create(:course, :user => user)
    visit courses_path
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
    assert page.has_content?(I18n.t('helpers.label.user.job'))
    assert page.has_content?(I18n.t('helpers.label.user.motivation'))
    assert page.has_content?(I18n.t('helpers.label.user.skills'))
    assert page.has_content?(I18n.t('helpers.label.user.description'))
    assert page.has_content?(I18n.t('helpers.label.user.user_images.image'))
    fill_in('user_user_skills_attributes_0_title', :with => 'Rails Programmierung')
    click_on I18n.t('user.edit.submit')
    assert page.has_content? I18n.t('user.edit.msg.success')
  end

end
