class NewsletterSubscribersController < ApplicationController

  require 'hash'

  def create
    email = params[:newsletter_subscriber][:email]
    @subscriber = NewsletterSubscriber.new(:email => email, :signout_hash => Hash.create_token(email))
    if @subscriber.valid?
      flash[:info] = I18n.t('newsletter_subscriber.create.success')
      redirect_to welcome_path
    else
      flash[:error] = I18n.t('newsletter_subscriber.create.fail')
      render 'pages/welcome', :layout => 'welcome'
    end
  end

  def unsubscribe
    if NewsletterSubscriber.unsubscribe(params[:token])
      flash[:info] = I18n.t('newsletter_subscriber.unsubscribe.success')
      redirect_to root_path
    else
      flash[:error] = I18n.t('newsletter_subscriber.unsubscribe.fail')
      redirect_to root_path
    end
  end

end
