require 'test_helper'

class SystemMailerTest < ActionMailer::TestCase
  test "begegnungsangebot" do
    user = Factory.create(:user)
    mail = SystemMailer.provide_course( user, "profile_link", "course_link")
    assert_equal I18n.t('mailer.subject.provide_course'), mail.subject
    assert_equal ["#{user.email}"], mail.to
    #assert_equal ["from@example.com"], mail.from
    assert_match "Benutzer", mail.body.encoded
    assert_match "wissenteilen", mail.body.encoded
  end

  test "begegnungsanfrage" do
    user = Factory.create(:user)
    mail = SystemMailer.request_course(user, "profile_link", "course_link")
    assert_equal I18n.t('mailer.subject.request_course'), mail.subject
    assert_equal ["#{user.email}"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Benutzer", mail.body.encoded
    assert_match "wissenteilen", mail.body.encoded
  end

  test "news" do
    user = Factory.create(:user)
    mail = SystemMailer.news(user.email, "Some stupid content")
    assert_equal I18n.t('mailer.subject.news'), mail.subject
    assert_equal ["#{user.email}"], mail.to
    assert_match "Some stupid content", mail.body.encoded
  end

end
