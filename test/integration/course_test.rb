require 'integration_test_helper'

class CourseTest < ActionDispatch::IntegrationTest

  should 'show course overview' do
    course1 = Factory.create(:course)
    course2 = Factory.create(:course)

    visit "/courses"

    assert page.has_content?(I18n.t('course.index.headline'))
    assert page.has_content?(course1.title)
    assert page.has_content?(course1.description)
    assert page.has_content?(course2.title)
    assert page.has_content?(course2.description)
  end

  should 'show course show action' do
    course = Factory.create(:course)
    visit "/"
    click_on course.title.to_s
    assert page.has_content?(course.title)
    assert page.has_content?(course.description)
  end

  should 'show course new action' do
    login_as
    visit "/courses/new"
    assert page.has_content?(I18n.t('course.new.headline'))
    assert page.has_content?(I18n.t('course.new.title'))
    assert page.has_content?(I18n.t('course.new.description'))
  end

  should 'be able to create new course with user session' do
    login_as
    click_on "create_course_button"
    assert_difference("Course.count") do
      fill_in('course_title', :with => 'Java programmierung')
      fill_in('course_description', :with => 'Applikationsprogrammierung mit Java')
      click_on(I18n.t('course.new.submit'))
    end
    assert current_path.to_s == courses_path
    assert page.has_content?(I18n.t('course.create.success'))
  end

  should 'not be able to create new course without user session' do
    visit "/courses/new"
    assert page.has_content?(I18n.t('devise.sessions.title'))
    assert page.has_content?(I18n.t('devise.failure.unauthenticated'))
  end
end
