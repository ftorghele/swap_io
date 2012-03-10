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

  should 'not be able to create skills' do
    visit "/"
    user = Factory.create(:user)
    login_as user
    click_on I18n.t('user.edit.title')
    click_on I18n.t('user.edit.tabs.about')
    fill_in('user_user_skills_attributes_0_title', :with => 'Rails Programmierung')
    User.any_instance.stubs(:update_attributes).returns(false)
    click_on I18n.t('user.edit.submit')
    assert page.has_content? I18n.t('user.edit.msg.fail')
  end

  should 'be able to accept user for course' do
    user1 = Factory.create(:user)
    user2 = Factory.create(:user)
    course = Factory.create(:course, :user => user2)
    course_member = Factory.create(:course_member, :user_id => user1.id, :course_id => course.id)
    login_as user2
    visit "/"
    assert page.has_content?(I18n.t('pages.overview.course_member_list'))
    click_on I18n.t('pages.overview.accept_course_member')
  end

  should 'show course_members on overview' do
    user1 = Factory.create(:user)
    user2 = Factory.create(:user)
    user3 = Factory.create(:user)
    course = Factory.create(:course, :user => user1)
    Factory.create(:course_member, :user_id => user2.id, :course_id => course.id)
    Factory.create(:course_member, :user_id => user3.id, :course_id => course.id)
    login_as user1
    visit "/"
    assert page.has_link?(user2.first_name << " " << user2.last_name)
    assert page.has_link?(user3.first_name << " " << user3.last_name)
    click_on I18n.t('pages.overview.accept_course_member')
    assert page.has_content?(I18n.t('course_member.update.success'))
    click_on I18n.t('pages.overview.reject_course_member')
    assert page.has_content?(I18n.t('course_member.update.rejected'))
  end

end
