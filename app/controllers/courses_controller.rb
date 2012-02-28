class CoursesController < ApplicationController

  before_filter :authenticate_user! , :only => [:new, :create]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create params[:course]
    if @course.save
      flash[:info] = I18n.t('course.create.success')
      redirect_to course_path(@course)
    else
      flash[:error] = I18n.t('course.create.fail')
      render :action => :new
    end
  end

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find_by_id(params[:id])
  end

  def destroy
  end

end
