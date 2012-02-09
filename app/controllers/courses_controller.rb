class CoursesController < ApplicationController

  before_filter :authenticate_user! , :only => [:new, :create]

  def new
    @course = Course.new
  end

  def create
    new_course = Course.new(params[:course])
    new_course.user_id = current_user.id if signed_in?
    if new_course.save
      flash[:message] = I18n.t('course.create.success')
      redirect_to courses_path
    else
      flash[:error] = I18n.t('course.create.fail')
      redirect_to new_course_path
    end
  end

  def index
    @courses = Course.find(:all)
  end

  def show
    @course = Course.find(params[:id])
  end

  def destroy
  end

end
