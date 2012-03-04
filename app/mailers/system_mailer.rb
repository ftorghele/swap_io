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

    mail to: user.email, subject: "#{I18n.t('mailer.subject.provide_course')}"
  end

  def request_course(user, user_profile_link, course_link )
    @user_profile_link = user_profile_link
    @course_link = course_link
    @user = user

    mail to: user.email, subject: "#{I18n.t('mailer.subject.request_course')}"
  end

  def news(email, body)
    @body = body
    @unsubscribe_token = Subscriber.find_by_email(email).signout_hash
    mail to: email, subject: "#{I18n.t('mailer.subject.news')}"
  end

end
