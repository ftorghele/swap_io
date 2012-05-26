class PagesController < ApplicationController
  def overview
    redirect_to :welcome unless signed_in?
  end

  def contact_us
    if SystemMailer.contact_us(params[:email_field], params[:subject], params[:body]).deliver
      flash[:info] = I18n.t('pages.contact.msg.success')
      redirect_to :welcome
    else
      flash[:error] = I18n.t('pages.contact.msg.fail')
      redirect_to :contact
    end
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
