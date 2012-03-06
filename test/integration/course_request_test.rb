require 'integration_test_helper'

class CourseTest < ActionDispatch::IntegrationTest

  should 'show course request overview' do
    course_request1 = Factory.create(:course_request)
    course_request2 = Factory.create(:course_request)

    visit course_requests_path

    assert page.has_content?(I18n.t('course_request.index.headline'))
    assert page.has_content?(course_request1.title)
    assert page.has_content?(course_request1.description)
    assert page.has_content?(course_request2.title)
    assert page.has_content?(course_request2.description)
  end

  should 'show course_request show action' do
    course_request = Factory.create(:course_request)
    visit course_requests_path
    click_on I18n.t('app.course_request_link')
    click_on course_request.title
    assert page.has_content?(course_request.title)
    assert page.has_content?(course_request.description)
  end

  should 'show course_request new action' do
    login_as
    visit new_course_request_path
    assert page.has_content?(I18n.t('course_request.new.headline'))
    assert page.has_content?(I18n.t('helpers.label.course_request.title'))
    assert page.has_content?(I18n.t('helpers.label.course_request.description'))
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
    visit new_course_request_path
    assert page.has_content?(I18n.t('devise.sessions.title'))
    assert page.has_content?(I18n.t('devise.failure.unauthenticated'))
  end

  should 'be able to join course_request' do
    user = Factory.create(:user)
    course_request = user.course_requests.create(:title => "bli", :description => "blup")
    login_as
    visit courses_path
    click_on I18n.t('app.course_request_link')
    click_on course_request.title

    assert page.has_content?(course_request.title)
    assert page.has_content?(course_request.description)
    assert page.has_button?(I18n.t('course_request.show.join_course_request_button'))
    click_on I18n.t('course_request.show.join_course_request_button')
    assert page.has_content?(I18n.t('course_request.join.success'))
    assert page.has_no_button?(I18n.t('course_request.show.join_course_request_button'))
  end

  should 'not be able to join course_request twice' do
    user = Factory.create(:user)
    course_request = user.course_requests.create(:title => "bli", :description => "blup")
    login_as(user)
    visit courses_path
    click_on I18n.t('app.course_request_link')
    click_on course_request.title

    assert page.has_content?(course_request.title)
    assert page.has_content?(course_request.description)
    assert page.has_no_button?(I18n.t('course_request.show.join_course_request_button'))
  end

  should 'be able to disjoin course_request' do
    user = Factory.create(:user)
    course_request = user.course_requests.create(:title => "bli", :description => "blup")
    login_as(user)
    visit courses_path
    click_on I18n.t('app.course_request_link')
    click_on course_request.title

    assert page.has_content?(course_request.title)
    assert page.has_content?(course_request.description)
    assert page.has_button?(I18n.t('course_request.show.disjoin_course_request_button'))
    click_on I18n.t('course_request.show.disjoin_course_request_button')
    assert page.has_content?(I18n.t('course_request.disjoin.success'))
    assert page.has_content?(I18n.t('course_request.index.headline'))
  end

  should 'be able to receive email if user provides course' do
    Factory.create(:category, :title => "Cooking")
    user = Factory.create(:user)
    user2 = Factory.create(:user)
    course_request = user.course_requests.create(:title => "bli", :description => "blup")
    user2.join_course_request(course_request)
    login_as

    visit courses_path
    click_on I18n.t('app.course_request_link')
    click_on course_request.title
    assert_difference "ActionMailer::Base.deliveries.count", 2 do
      click_on I18n.t('course_request.show.provide_course_request_button')
      select 'Cooking', :from => 'course_category_id'
      click_on I18n.t('course.new.submit')
      assert page.has_content?(I18n.t('course.create.success'))
    end
  end

end
