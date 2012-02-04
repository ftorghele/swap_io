class CoursesController < ApplicationController

  def new
    @course = Course.new
  end

  def create
    @new_course = Course.create(params[:course])
    if @new_course.valid?
      flash[:message] = "Course created successfully"
      redirect_to courses_path
    else
      flash[:warning] = "Failed to create course"
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
