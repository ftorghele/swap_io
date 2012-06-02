require 'integration_test_helper'

class CourseTest < ActionDispatch::IntegrationTest

  should 'show course request overview' do
    course_request1 = Factory.build(:course_request)
    course_request1.categories << Factory.create(:category)
    course_request1.users << Factory.create(:user)
    course_request1.save
    course_request2 = Factory.build(:course_request)
    course_request2.categories << Factory.create(:category)
    course_request2.users << Factory.create(:user)
    course_request2.save
    visit "/Begegnungswuensche"
    assert page.has_content?(course_request1.title)
    assert page.has_content?(course_request2.title)
  end

  should 'show course_request show action' do
    course_request = Factory.build(:course_request)
    course_request.categories << Factory.create(:category)
    course_request.users << Factory.create(:user)
    course_request.save
    visit "/Begegnungswuensche"
    assert page.has_content?(course_request.title)
  end

  should 'show course_request new action' do
    course_request = Factory.build(:course_request)
    course_request.categories << Factory.create(:category)
    course_request.users << Factory.create(:user)
    course_request.save
    login_as
    visit "/#{I18n.t('routes.course_requests.as')}/new"
    assert page.has_content? "Neuer Begegnungswunsch"
    assert page.has_content? "Titel*"
    assert page.has_content? "Beschreibung*"
  end

  should 'be able to join course_request' do
    course_request = Factory.build(:course_request)
    course_request.categories << Factory.create(:category)
    course_request.users << Factory.create(:user)
    course_request.save
    login_as
    visit "Begegnungswuensche"
    click_on course_request.title
    assert page.has_content?(course_request.title)
    assert page.has_content?(course_request.description)
  end

  should 'not be able to join course_request twice' do
    course_request = Factory.build(:course_request)
    course_request.categories << Factory.create(:category)
    course_request.users << user = Factory.create(:user)
    course_request.save
    login_as(user)
    visit course_requests_path
    click_on course_request.title

    assert page.has_content?(course_request.title)
    assert page.has_content?(course_request.description)
    assert page.has_no_button?(I18n.t('course_request.show.join_course_request_button'))
  end

  should 'be able to disjoin course_request' do
    course_request = Factory.build(:course_request)
    course_request.categories << Factory.create(:category)
    course_request.users << user = Factory.create(:user)
    course_request.save
    login_as(user)
    visit courses_path
    click_on I18n.t('app.course_request_link')
    click_on course_request.title
    assert page.has_content?(course_request.title)
    assert page.has_content?(course_request.description)
    click_on "Kein Interesse mehr"
    assert page.has_content?(I18n.t('course_request.disjoin.success'))
  end

  # should 'be able to receive email if user provides course' do
  #   Factory.create(:category, :title => "Cooking")
  #   user = Factory.create(:user)
  #   user2 = Factory.create(:user)
  #   course_request = user.course_requests.create(:title => "bli", :description => "blup")
  #   user2.join_course_request(course_request)
  #   login_as
  #   visit courses_path
  #   click_on I18n.t('app.course_request_link')
  #   click_on course_request.title
  #   assert_difference "ActionMailer::Base.deliveries.count", 2 do
  #     click_on I18n.t('course_request.show.provide_course_request_button')
  #     select 'Cooking', :from => 'course_category_id'
  #     click_on I18n.t('course.new.submit')
  #     assert page.has_content?(I18n.t('course.create.success'))
  #   end
  # end

end
