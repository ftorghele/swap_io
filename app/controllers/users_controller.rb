class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def fb_finish
    unless @user = User.create!(params[:user])
      render :complete
    else
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      @user.confirm!
      sign_in_and_redirect @user, :event => :authentication
    end

  end
end
