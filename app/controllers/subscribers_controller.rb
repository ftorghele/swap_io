class SubscribersController < ApplicationController

  require 'hash'

  def create
    newsletter = Newsletter.first if Newsletter.first.present?
    email = params[:subscriber][:email]


    @subscriber = Subscriber.new(:email => email, :signout_hash => Hash.create_token(email), :newsletter => newsletter )

    if @subscriber.valid?
      @subscriber.save!
      flash[:info] = I18n.t('subscriber.create.success')
      redirect_to :back

    else
      flash[:error] = I18n.t('subscriber.create.fail')
      render 'pages/welcome', :layout => 'welcome'
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
