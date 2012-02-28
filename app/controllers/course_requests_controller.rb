class CourseRequestsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :join]

  def show
    @course_request = CourseRequest.find(params[:id])
  end

  def index
    @course_requests = CourseRequest.all
  end

  def new
    @course_request = CourseRequest.new
  end

  def create
    @course_request = current_user.course_requests.create(params[:course_request])
    if @course_request.save
      flash[:message] = I18n.t('course_request.create.success')
      redirect_to course_requests_path
    else
      flash[:error] = I18n.t('course_request.create.fail')
      render :action => :new
    end
  end

  def join
    #TODO handle fail
    @course_request = CourseRequest.find(params[:course_request_id])
    current_user.course_requests << @course_request if signed_in?
    flash[:message] = I18n.t('course_request.join.success')
    redirect_to :back
  end

end
