class UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:facebook, :fb_create] #, :only => [:edit, :update, :settings, :my_courses, :my_course_requests, :my_conversations]
  before_filter :get_user, :only => [:edit, :update, :settings, :my_courses, :my_course_requests]

  def my_courses
  end

  def my_course_requests
  end

  def show
    @user = User.find(params[:id])
    @rating = @user.user_ratings.build
  end

  def edit
  end

  def settings
  end

  def update
    @user.update_attributes(params[:user])
    if @user.valid?
      @user.save!
      flash[:info] = I18n.t('msg.success')
      if params[:user][:image].blank? || params[:javascript].blank?
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
      #@user.confirm!
      @user.save!
      sign_in_and_redirect @user, :event => :authentication
    end
  end

  private

  def get_user
    @user = current_user
  end
end
