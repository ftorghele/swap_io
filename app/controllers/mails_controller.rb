class MailsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @user = User.find(params[:id])
  end

  def create
    user = User.find(params[:user_id])
    if SystemMailer.private_message(user, current_user, params[:body]).deliver
      flash[:info] = I18n.t('mails.create.success')
    else
      flash[:error] = I18n.t('mails.create.fail')
    end
    redirect_to user_path(user)
  end

end
