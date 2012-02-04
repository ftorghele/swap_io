class CoursesController < ApplicationController

  def new
    @course = Course.new
  end

  def create
    @new_course = Course.create(params[:course])
    if @new_course.valid?
      flash[:message] = I18n.t('course.create.success')
      redirect_to courses_path
    else
      flash[:warning] = I18n.t('course.create.fail')
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
