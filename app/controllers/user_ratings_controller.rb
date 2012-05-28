class UserRatingsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_user, :only => [:create]

  def create
    @rating = @user.user_ratings.build(params[:user_rating])
    @rating.evaluator_id = current_user.id
    if @rating.valid?
      @rating.save!
      flash[:info] = I18n.t('user_rating.create.success')
      redirect_to user_path(@user)
    else
      flash[:error] = I18n.t('user_rating.create.fail')
      render "users/show"
    end
  end

  private

  def check_user
    @user = User.find(params[:user_id])
    if @user == current_user
      flash[:error] = I18n.t('user_rating.create.fail_self')
      redirect_to user_path(@user) and return
    end
  end
end
