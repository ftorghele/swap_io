class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
  end

  def edit
    @user = User.find_by_id(params[:id])
    @user.user_images.build
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.update_attributes(params[:user])
    flash[:info] = I18n.t('user.edit.msg.success')
    redirect_to user_path(@user)
  end


  def fb_create
    @user = User.new(params[:user])
    @user.password = Devise.friendly_token[0,20]
    unless @user.valid?
      render :complete_registration
    else
      flash[:info] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      @user.confirm!
      @user.save!
      sign_in_and_redirect @user, :event => :authentication
    end
  end
end
