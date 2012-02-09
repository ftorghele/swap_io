class CourseRequestsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create]

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
    new_course_request = CourseRequest.new(params[:course_request])
    new_course_request.user_id = current_user.id if signed_in?

    if new_course_request.save
      flash[:message] = I18n.t('course_request.create.success')
      redirect_to course_requests_path
    else
      flash[:error] = I18n.t('course_request.create.fail')
      redirect_to new_course_request_path
    end
  end

end
