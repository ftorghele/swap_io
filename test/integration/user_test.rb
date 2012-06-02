require 'integration_test_helper'

class UserTest < ActionDispatch::IntegrationTest

  should 'show user profile action' do
    user = Factory.create(:user, :description => "blabla")
    course = Factory.build(:course, :user => user)
    course.categories << Factory.create(:category)
    course.save
    visit "/Mitglied/#{user.id}"
    assert page.has_selector?('img')
    assert page.has_content?(user.first_name)
    assert page.has_content?(user.last_name)
    assert page.has_content?(user.description)
  end

#   should 'be able to accept user for course' do
#     user1 = Factory.create(:user)
#     user2 = Factory.create(:user)
#     course = Factory.build(:course, :user => user2)
#     course.categories << Factory.create(:category)
#     course.save
#     course_member = Factory.create(:course_member, :user_id => user1.id, :course_id => course.id)
#     login_as user2
#     visit "/Meine_Begegnungen"
# save_and_open_page
#     assert page.has_link?(user2.first_name << " " << user2.last_name)
#   end

  # should 'be able to render email new action if logged in' do
  #   user = Factory.create(:user)
  #   login_as
  #   visit "/#{I18n.t('routes.users.as')}/#{user.id}"
  #   assert page.has_link?("email")
  #   click_on "email"
  #   assert page.has_content?(I18n.t('mails.new.title'))
  # end

  should 'not be able to render email new action if not logged in' do
    user = Factory.create(:user)
    visit "/#{I18n.t('routes.users.as')}/#{user.id}"
    assert page.has_no_link?("email")
  end

  # should 'be able to send private message to other user' do
  #   user = Factory.create(:user)
  #   login_as
  #   visit "/#{I18n.t('routes.users.as')}/#{user.id}"
  #   click_on "email"
  #   fill_in('body', :with => 'Hi there whats up')
  #   SystemMailer.expects(:private_message).returns mock(:deliver => true)
  #   click_on I18n.t('mails.new.submit')
  #   assert page.has_content?(user.first_name)
  #   assert page.has_content?(user.last_name)
  # end

end
