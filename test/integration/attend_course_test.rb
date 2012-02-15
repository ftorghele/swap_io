require 'integration_test_helper'

class AttendCourseTest < ActionDispatch::IntegrationTest

  should 'be able to attend course' do
    user = Factory.create(:user)
    course = Factory.create(:course, :user => user)
    login_as
    visit "/"
    click_on course.title
    assert_difference "AttendCourse.count" do
      click_on I18n.t('course.show.attend_course_button')
      assert page.has_content?(I18n.t('attend_course.create.success'))
    end
  end

  should 'not be able to attend own course' do
    user = Factory.create(:user)
    course = Factory.create(:course, :user => user)
    login_as(user)
    visit "/"
    click_on course.title
    assert page.has_no_button?(I18n.t('course.show.attend_course_button'))
  end

  should 'not be able to attend course without login' do
    user = Factory.create(:user)
    course = Factory.create(:course, :user => user)
    visit "/"
    click_on course.title
    assert page.has_no_button?(I18n.t('course.show.attend_course_button'))
  end

  should 'be able to attend more than one course' do
    user1 = Factory.create(:user)
    course1 = Factory.create(:course, :user => user1)
    course2 = Factory.create(:course, :user => user1)
    login_as
    visit "/"
    click_on course1.title
    click_on(I18n.t('course.show.attend_course_button'))
    assert page.has_content?(I18n.t('attend_course.create.success'))
    click_on course1.title
    assert page.has_no_button?(I18n.t('course.show.attend_course_button'))
    visit "/"
    click_on course2.title
    click_on(I18n.t('course.show.attend_course_button'))
    assert page.has_content?(I18n.t('attend_course.create.success'))
    click_on course2.title
    assert page.has_no_button?(I18n.t('course.show.attend_course_button'))
  end
end
