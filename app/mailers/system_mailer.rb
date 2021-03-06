class SystemMailer < ActionMailer::Base
  require 'hash'

  default from: "info@wissenteilen.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.system_mailer.info.subject
  #
  def provide_course(user, host, course )
    @host = host
    @course = course
    @user = user
    @subject = I18n.t('mailer.subject.provide_course')

    mail to: user.email, subject: @subject do |format|
      format.html
      format.text
    end
  end

  def request_course(user, requester, course )
    @requester = requester
    @course = course
    @user = user
    @subject = "Begegnungsanfrage"

    mail to: user.email, subject: @subject do |format|
      format.html
      format.text
    end
  end

  def accept_course_member(user, course)
    @course = course
    @subject = I18n.t('mailer.subject.accept_course_member')
    @user = user

    mail to: user.email, subject: @subject do |format|
      format.html
      format.text
    end
  end

  def reject_course_member(user, course)
    @course = course
    @subject = I18n.t('mailer.subject.reject_course_member')
    @user = user

    mail to: user.email, subject: @subject do |format|
      format.html
      format.text
    end
  end

  #regex to replace html tags from string
  # <([^>]*)>
  # find html tag and replace by line ending
  # gsub!(/<([^>]*)>/){"\n"}
  def news(email, body)
    @body = body
    @subject = I18n.t('mailer.subject.news')
    @unsubscribe_token = NewsletterSubscriber.find_by_email(email).signout_hash
    mail to: email, subject: @subject do |format|
      format.html
      format.text
    end
  end

  def contact_us(email, subject, body)
    @email = email
    @subject = subject
    @body = body
    mail to: "info@wissenteilen.com", subject: subject, from: email do |format|
      format.html
      format.text
    end
  end

  def delete_course(receiver, course)
    @sender = course.user
    @subject = "Begegnung abgesagt"
    @receiver = receiver
    @course = course
    mail to: receiver.email, subject: @subject do |format|
      format.html
      format.text
    end
  end

  def private_message(receiver, sender, body, subject=I18n.t('mailer.subject.private_message'))
    @sender = sender
    @subject = subject
    @body = body
    @receiver = receiver
    mail to: receiver.email, subject: @subject do |format|
      format.html
      format.text
    end
  end

  def send_course_member_notification(user, course)
    @user = user
    @course = course
    @subject = "Begegnung bewerten"
    mail to: user.email, subject: @subject do |format|
      format.html
      format.text
    end
  end
end
