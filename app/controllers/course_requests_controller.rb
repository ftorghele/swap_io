class CourseRequestsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :join, :disjoin]
  before_filter :get_course_request, :only => [:show, :edit, :update, :destroy]

  def index
    if signed_in?
      @course_requests = CourseRequest.find_category_abonnements(current_user, false)
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

  def show
  end

  def new
    @course_request = CourseRequest.new
  end

  def create
    @course_request = current_user.course_requests.create(params[:course_request])
    if @course_request.valid?
      @course_request.save!
      flash[:info] = I18n.t('course_request.create.success')
      redirect_to course_requests_path
    else
      flash_right_error
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

  private

  def get_course_request
    unless @course_request = CourseRequest.find_by_id(params[:id])
      flash[:error] = I18n.t('msg.not_found')
      redirect_to courses_path and return
    end
  end

  def flash_right_error
    cat_array = params[:course_request][:category_ids]
    if cat_array.nil? || cat_array.empty?
      flash[:error] = I18n.t('course.msg.no_categories')
    elsif cat_array.count > 3
      flash[:error] = I18n.t('course.msg.too_much_categories')
    else
      flash[:error] = I18n.t('course.msg.fail')
    end
  end

end
