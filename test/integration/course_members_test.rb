require 'integration_test_helper'

class CourseMembersTest < ActionDispatch::IntegrationTest

  should 'be able to attend course' do
    user = Factory.create(:user)
    course = Factory.build(:course, :user => user)
    course.categories << Factory.create(:category)
    course.save
    login_as
    visit "/begegnungen/#{course.id}"

    assert_difference "CourseMember.count" do
      assert_difference "ActionMailer::Base.deliveries.count" do
        click_on "Teilnahme anfragen"
        assert page.has_content?(I18n.t('course_member.create.success'))
      end
    end
  end

  should 'not be able to attend own course' do
    user = Factory.create(:user)
    course = Factory.build(:course, :user => user)
    course.categories << Factory.create(:category)
    course.save
    login_as(user)
    visit courses_path
    click_on I18n.t('app.course_link')
    click_on course.title
    assert page.has_no_button?(I18n.t('course.show.course_member_button'))
  end

  should 'not be able to attend course without login' do
    user = Factory.create(:user)
    course = Factory.build(:course, :user => user)
    course.categories << Factory.create(:category)
    course.save
    visit "/begegnungen/#{course.id}"
    click_on "Teilnahme anfragen"
    assert page.has_content? "Einloggen"
    assert page.has_no_button? "Teilnahme absagen"
  end

  should 'be able to attend more than one course' do
    user = Factory.create(:user)
    course1 = Factory.build(:course, :user => user)
    course1.categories << Factory.create(:category)
    course1.save
    course2 = Factory.build(:course, :user => user)
    course2.categories << Factory.create(:category)
    course2.save
    login_as
    visit "/begegnungen/#{course1.id}"

    click_on "Teilnahme anfragen"
    assert page.has_content?(I18n.t('course_member.create.success'))
    visit "/begegnungen/#{course1.id}"

    assert page.has_no_button? "Teilnahme anfragen"
    click_on "Begegnungen"
    visit "/begegnungen/#{course2.id}"

    click_on "Teilnahme anfragen"
    assert page.has_content?(I18n.t('course_member.create.success'))
  end
end
