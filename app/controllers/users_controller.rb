class UsersController < ApplicationController

  before_filter :authenticate_user! , :only => [:new, :create]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user)
    @user.user_images.build
    @user.user_skills.build
  end

  def settings
    @user = User.find(current_user)
  end

  def update
    if User.find(current_user).update_attributes(params[:user])
      flash[:info] = I18n.t('user.edit.msg.success')
    else
      flash[:error] = I18n.t('user.edit.msg.fail')
    end
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
