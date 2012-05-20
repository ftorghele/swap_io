class PagesController < ApplicationController
  def overview
    redirect_to :welcome unless signed_in?
  end

  def contact_us
    if SystemMailer.contact_us(params[:email_field], params[:subject], params[:body]).deliver
      flash[:message] = I18n.t('pages.contact.msg.success')
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
  end
end
