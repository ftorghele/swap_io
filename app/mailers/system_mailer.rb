class SystemMailer < ActionMailer::Base
  require 'hash'

  default from: "info@wissenteilen.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.system_mailer.info.subject
  #
  def provide_course(user, user_profile_link, course_request_link )
    @user_profile_link = user_profile_link
    @course_request_link = course_request_link
    @user = user
    @subject = I18n.t('mailer.subject.provide_course')

    mail to: user.email, subject: @subject
  end

  def request_course(user, user_profile_link, course_link )
    @user_profile_link = user_profile_link
    @course_link = course_link
    @user = user
    @subject = I18n.t('mailer.subject.request_course')

    mail to: user.email, subject: @subject
  end

  def accept_course_member(user, course)
    @user = user
    @course = course
    @subject = I18n.t('mailer.subject.accept_course_member')

    mail to: user.email, subject: @subject
  end

  def reject_course_member(user, course)
    @user = user
    @course = course
    @subject = I18n.t('mailer.subject.reject_course_member')

    mail to: user.email, subject: @subject
  end

  def news(email, body)
    @body = body
    @subject = I18n.t('mailer.subject.news')
    @unsubscribe_token = NewsletterSubscriber.find_by_email(email).signout_hash
    mail to: email, subject: @subject
  end

  def contact_us(email, subject, body)
    @email = email
    @subject = subject
    @body = body
    mail to: "info@wissenteilen.com", subject: subject, from: email
  end

  def private_message(user, subject=I18n.t('mailer.subject.private_message'), body)
    @user = user
    @subject = subject
    @body = body
    mail to: user.email, subject: @subject
  end
end
