class CourseRequestsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :join, :disjoin]

  def show
    @course_request = CourseRequest.find(params[:id])
  end

  def index
    if signed_in?
      @course_requests = CourseRequest.find_category_abonnements_course_requests current_user
      cookies[:categories] = CourseRequest.load_user_cookie current_user
    else
      if cookies[:categories].present?
        @course_requests = CourseRequest.set_courses JSON.parse(cookies[:categories])
      else
        cookies[:categories] = Course.set_new_cookie
        @course_requests = CourseRequest.all
      end
    end
    @categories = JSON.parse cookies[:categories]
  end

  def new
    @course_request = CourseRequest.new
  end

  def create
    if current_user.course_requests.create(params[:course_request])
      flash[:info] = I18n.t('course_request.create.success')
      redirect_to course_requests_path
    else
      flash[:error] = I18n.t('course_request.create.fail')
      render :action => :new
    end
  end

  def join
    if course_request = CourseRequest.find_by_id(params[:course_request_id])
      if current_user.join_course_request course_request
        flash[:info] = I18n.t('course_request.join.success')
      else
        flash[:error] = I18n.t('course_request.join.fail')
      end
    else
      flash[:error] = I18n.t('course_request.join.fail')
    end
    redirect_to CourseRequest.find_by_id(course_request) ? course_request_path(course_request) : course_requests_path
  end

  def disjoin
    if course_request = CourseRequest.find_by_id(params[:course_request_id])
      if current_user.disjoin_course_request course_request
        flash[:info] = I18n.t('course_request.disjoin.success')
      else
        flash[:error] = I18n.t('course_request.disjoin.fail')
      end
    else
      flash[:error] = I18n.t('course_request.disjoin.fail')
    end
    redirect_to CourseRequest.find_by_id(course_request) ? course_request_path(course_request) : course_requests_path
  end

end
