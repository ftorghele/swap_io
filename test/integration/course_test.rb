require 'integration_test_helper'

class CourseTest < ActionDispatch::IntegrationTest

  should 'show course overview' do
    course1 = Factory.create(:course)
    course2 = Factory.create(:course)

    visit "/courses"

    assert page.has_selector?('img')
    assert page.has_content?(I18n.t('course.index.created_from'))
    assert page.has_content?(I18n.t('course.index.headline'))
    assert page.has_content?(course1.title)
    assert page.has_content?(course1.description)
    assert find_link("#{course1.user.first_name} #{course1.user.last_name}")
    assert page.has_content?(course2.title)
    assert page.has_content?(course2.description)
    assert find_link("#{course2.user.first_name} #{course2.user.last_name}")
  end

  should 'show course show action for logged in user' do
    login_as
    course = Factory.create(:course)
    visit "/"
    click_on I18n.t('app.course_link')
    click_on course.title.to_s
    assert page.has_selector?('img')
    assert page.has_content?(course.title)
    assert page.has_content?(course.description)
    assert page.has_content?(I18n.t('course.show.created_from'))
    assert find_link("#{course.user.first_name} #{course.user.last_name}")
  end

  should 'show course new action' do
    login_as
    visit "/courses/new"
    assert page.has_content?(I18n.t('course.new.headline'))
    assert page.has_content?(I18n.t('helpers.label.course.title'))
    assert page.has_content?(I18n.t('helpers.label.course.description'))
    assert page.has_content?(I18n.t('course.new.select'))
    assert page.has_content?(I18n.t('helpers.label.course.category_id'))
  end

  should 'be able to create new course with user session' do
    category = Factory.create(:category, :title => "Cooking")
    login_as
    click_on I18n.t('app.course_link')
    click_on "create_course_button"
    assert_difference("Course.count") do
      fill_in('course_title', :with => 'Java programmierung')
      fill_in('course_description', :with => 'Applikationsprogrammierung mit Java')
      select(category.title, :from => 'course_category_id')
      click_on(I18n.t('course.new.submit'))
    end
    assert current_path.to_s == course_path(Course.last)
    assert page.has_content?(I18n.t('course.create.success'))
  end

  should 'not be able to create new course without user session' do
    visit "/courses/new"
    assert page.has_content?(I18n.t('devise.sessions.title'))
    assert page.has_content?(I18n.t('devise.failure.unauthenticated'))
  end

  should 'fill in course_request data if exist for course provider' do
    user = Factory.create(:user)
    user2 = Factory.create(:user)
    course_request = Factory.create(:course_request)
    user.join_course_request(course_request)
    login_as user2
    visit course_request_path(course_request.id)
    click_on I18n.t('course_request.show.provide_course_request_button')
  end

  should 'be deletable from owner' do
    user = Factory.create(:user)
    course = Factory.create(:course, :user => user)
    login_as user
    visit "/"
    assert page.has_content?(course.title)
    assert page.has_button?(I18n.t('pages.overview.delete_link'))
    click_on I18n.t('pages.overview.delete_link')
    assert page.has_no_content?(course.title)
    assert page.has_content? I18n.t('course.destroy.success')
  end
end
