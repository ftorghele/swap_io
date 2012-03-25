require 'test_helper'

class SystemMailerTest < ActionMailer::TestCase
  test "provide_course" do
    user = Factory.create(:user)
    mail = SystemMailer.provide_course( user, "profile_link", "course_link")
    assert_equal I18n.t('mailer.subject.provide_course'), mail.subject
    assert_equal ["#{user.email}"], mail.to
    assert_match "Benutzer", mail.body.encoded
    assert_match "wissenteilen", mail.body.encoded
  end

  test "request_course" do
    user = Factory.create(:user)
    mail = SystemMailer.request_course(user, "profile_link", "course_link")
    assert_equal I18n.t('mailer.subject.request_course'), mail.subject
    assert_equal ["#{user.email}"], mail.to
    assert_equal ["info@wissenteilen.com"], mail.from
    assert_match "Benutzer", mail.body.encoded
    assert_match "wissenteilen", mail.body.encoded
  end

  test "accept_course_member" do
    user = Factory.create(:user)
    course = Factory.create(:course)
    mail = SystemMailer.accept_course_member(user, course)
    assert_equal I18n.t('mailer.subject.accept_course_member'), mail.subject
    assert_equal ["#{user.email}"], mail.to
    assert_equal ["info@wissenteilen.com"], mail.from
    assert_match "Begegnung", mail.body.encoded
    assert_match "href", mail.body.encoded
    assert_match I18n.t('mailer.subject.accept_course_member'), mail.body.encoded
  end

  test "reject_course_member" do
    user = Factory.create(:user)
    course = Factory.create(:course)
    mail = SystemMailer.reject_course_member(user, course)
    assert_equal I18n.t('mailer.subject.reject_course_member'), mail.subject
    assert_equal ["#{user.email}"], mail.to
    assert_equal ["info@wissenteilen.com"], mail.from
    assert_match "Begegnung", mail.body.encoded
    assert_match "href", mail.body.encoded
    assert_match "abgelehnt", mail.body.encoded
    assert_match I18n.t('mailer.subject.reject_course_member'), mail.body.encoded
  end

  test "news" do
    subscriber = Factory.create(:newsletter_subscriber)
    mail = SystemMailer.news(subscriber.email, "Some stupid content")
    assert_equal I18n.t('mailer.subject.news'), mail.subject
    assert_equal ["#{subscriber.email}"], mail.to
    assert_match "Some stupid content", mail.body.encoded
  end

  test "private message" do
    user = Factory.create(:user)
    mail = SystemMailer.private_message(user, "Some stupid content")
    assert_equal I18n.t('mailer.subject.private_message'), mail.subject
    assert_equal ["#{user.email}"], mail.to
    assert_match "Some stupid content", mail.body.encoded
  end
end
