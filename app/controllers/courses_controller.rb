class CoursesController < ApplicationController

  before_filter :authenticate_user! , :only => [:new, :create]

  def new
    if @course_request = CourseRequest.find_by_id(params[:id])
      @course = Course.new( :title => @course_request.title, :description => @course_request.description)
    else
      @course = Course.new
    end
  end

  def create
    @course = current_user.courses.new( params[:course] )
    if @course.save
      flash[:info] = I18n.t('course.create.success')
      @course.provide_course_mailer params[:type] if params[:type]
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
