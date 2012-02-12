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
    login_as user
    visit "/"
    click_on course.title
    assert page.has_no_content?(I18n.t('course.show.attend_course_button'))
  end

  should 'not be able to attend course without login' do
    user = Factory.create(:user)
    course = Factory.create(:course, :user => user)
    visit "/"
    click_on course.title
    assert page.has_no_content?(I18n.t('course.show.attend_course_button'))
  end

end
