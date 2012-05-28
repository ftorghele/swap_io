class UsersController < ApplicationController

  before_filter :authenticate_user! , :only => [:new, :create]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user)
  end

  def settings
    @user = User.find(current_user)
  end

  def update
    @user = User.find(current_user)
    @user.update_attributes(params[:user])
    if @user.valid?
      @user.save!
      flash[:info] = I18n.t('msg.success')
      if params[:user][:image].blank?
        redirect_to user_path(@user)
      else
        render "shared/crop", :locals => {:obj => @user}
      end
    else
      flash[:error] = I18n.t('msg.fail')
      redirect_to user_path(@user)
    end
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
