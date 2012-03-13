class NewslettersController < ApplicationController

  def update
    if Newsletter.spread_newsletter params[:id]
      flash[:info] = I18n.t('newsletter.update.success')
      redirect_to admin_newsletters_path
    else
      flash[:error] = I18n.t('newsletter.update.fail')
      redirect_to admin_newsletters_path
    end
  end

end
