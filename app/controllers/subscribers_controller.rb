class SubscribersController < ApplicationController

  require 'hash'

  def create
    email = params[:email]
    if Newsletter.first.present?
      newsletter = Newsletter.first
      Subscriber.create(:email => email, :signout_hash => Hash.create_token(email), :newsletter_id => newsletter.id )
      flash[:info] = I18n.t('subscriber.create.success')
      redirect_to :back
    else
      flash[:error] = I18n.t('subscriber.create.fail')
      redirect_to :back
    end
  end

  def unsubscribe
    if Subscriber.unsubscribe(params[:token])
      flash[:info] = I18n.t('subscriber.unsubscribe.success')
      redirect_to 'home'
    else
      flash[:error] = I18n.t('subscriber.unsubscribe.fail')
      redirect_to 'home'
    end
  end

end
