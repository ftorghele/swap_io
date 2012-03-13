class NewsletterSubscribersController < ApplicationController

  require 'hash'

  def create
    email = params[:newsletter_subscriber][:email]
    if @subscriber = NewsletterSubscriber.create(:email => email, :signout_hash => Hash.create_token(email) )
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
