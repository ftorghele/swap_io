class PagesController < ApplicationController

  before_filter :authenticate_user!, :except => [:landingpage, :create, :unsubscribe]

  def contact_us
    unless params[:email_field].blank? || params[:subject].blank? || params[:body].blank?
      if SystemMailer.contact_us(params[:email_field], params[:subject], params[:body]).deliver
        flash[:info] = I18n.t('pages.contact.msg.success')
        redirect_to :welcome and return
      end
    end
    flash[:error] = I18n.t('pages.contact.msg.fail')
    render :contact
  end

  def landingpage
    @subscriber = NewsletterSubscriber.new
    render :layout => 'landingpage'
  end

  def welcome
    if signed_in?
      @courses = Course.find_category_abonnements current_user, true
      cookies[:categories] = Course.load_user_cookie current_user
    else
      if cookies[:categories].present?
        @courses = Course.set_courses JSON.parse(cookies[:categories])
      else
        cookies[:categories] = Course.set_new_cookie
        @courses = Course.all
      end
    end
    @categories = JSON.parse cookies[:categories]
  end
end
