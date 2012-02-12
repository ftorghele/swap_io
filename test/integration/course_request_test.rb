require 'integration_test_helper'

class CourseTest < ActionDispatch::IntegrationTest

  should 'show course request overview' do
    course_request1 = Factory.create(:course_request)
    course_request2 = Factory.create(:course_request)

    visit "/course_requests"

    assert page.has_content?(I18n.t('course_request.index.headline'))
    assert page.has_content?(course_request1.title)
    assert page.has_content?(course_request1.description)
    assert page.has_content?(course_request2.title)
    assert page.has_content?(course_request2.description)
  end

  should 'show course_request show action' do
    course_request = Factory.create(:course_request)
    visit "/"
    click_on I18n.t('app.course_request_link')
    click_on course_request.title.to_s
    assert page.has_content?(course_request.title)
    assert page.has_content?(course_request.description)
  end

  should 'show course_request new action' do
    login_as
    visit "/course_requests/new"
    assert page.has_content?(I18n.t('course_request.new.headline'))
    assert page.has_content?(I18n.t('course_request.new.title'))
    assert page.has_content?(I18n.t('course_request.new.description'))
  end

  should 'be able to create course_request' do
    login_as
    click_on I18n.t('app.course_request_link')
    click_on "create_course_request_button"
    assert_difference "CourseRequest.count" do
      fill_in('course_request_title', :with => 'Java programmierung')
      fill_in('course_request_description', :with => 'Applikationsprogrammierung mit Java')
      click_on I18n.t('course_request.new.submit')
    end
    assert current_path.to_s == course_requests_path
    assert page.has_content?(I18n.t('course_request.create.success'))

  end

  should 'not be able to create course_request without login' do
    visit "/course_requests/new"
    assert page.has_content?(I18n.t('devise.sessions.title'))
    assert page.has_content?(I18n.t('devise.failure.unauthenticated'))
  end
end
