require 'integration_test_helper'

class CourseTest < ActionDispatch::IntegrationTest

  should 'show course overview' do
    course1 = Factory.build(:course)
    course1.categories << Factory.create(:category)
    course1.save
    course2 = Factory.build(:course)
    course2.categories << Factory.create(:category)
    course2.save
    login_as
    visit "/Begegnungen"
    assert page.has_selector?('img')
    assert page.has_content? course1.title
    assert page.has_content?(course1.description)
    assert page.has_content?(course2.title)
    assert page.has_content?(course2.description)
  end

  should 'show course show action for logged in user' do
    course = Factory.build(:course)
    course.categories << Factory.create(:category)
    course.save
    login_as
    visit "/#{I18n.t('routes.courses.as')}/#{course.id}"
    assert page.has_selector?('img')
    assert page.has_content?(course.title)
    assert page.has_content?(course.description)
    assert find_link("#{course.user.first_name} #{course.user.last_name}")
  end

  should 'show course new action' do
    course = Factory.build(:course)
    course.categories << Factory.create(:category)
    course.save
    login_as
    visit "/Begegnungen/new"
    assert page.has_content? "Neue Begegnung"
    assert page.has_content? "Titel der Begegnung*"
    assert page.has_content? "Kategorien (max. 3)*"
  end

  should 'not be able to create new course without user session' do
    visit "/courses/new"
    assert page.has_content?(I18n.t('devise.sessions.title'))
    assert page.has_content?(I18n.t('devise.failure.unauthenticated'))
  end

  should 'be deletable from owner' do
    user = Factory.create(:user)
    course = Factory.build(:course, :user => user)
    course.categories << Factory.create(:category)
    course.save
    login_as user
    visit "/#{I18n.t('routes.courses.as')}/#{course.id}"
    assert page.has_content?(course.title)
    click_on "Begegnung absagen"
    assert page.has_no_content?(course.title)
  end

end
