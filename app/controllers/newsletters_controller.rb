class NewslettersController < ApplicationController

  def update
    if Newsletter.spread_newsletter params[:id]
      flash[:info] = I18n.t('newsletter.update.success')
      redirect_to :back
    else
      flash[:error] = I18n.t('newsletter.update.fail')
      redirect_to :back
    end
  end

end
