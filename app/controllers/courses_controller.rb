class CoursesController < ApplicationController
  require 'json'

  before_filter :authenticate_user! , :only => [:new, :create]

  def index

    if params[:courses] == 'false' #only to show startscreen
      @courses = nil
    else
      @courses = Course.all
    end

  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    if @course_request = CourseRequest.find_by_id(params[:id])
      @course = Course.new( :title => @course_request.title, :description => @course_request.description)
    else
      @course = Course.new
    end
  end

  def create
    @course = current_user.courses.new( params[:course] )
    if @course.save!
      flash[:message] = I18n.t('course.create.success')
      @course.provide_course_mailer params[:type] if params[:type]
      redirect_to course_path(@course)
    else
      flash[:error] = I18n.t('course.create.fail')
      render :action => :new
    end
  end

  def index
    if signed_in?
      #@categories = Category.find_all_by_id(current_user.find_category_abonnements).collect{|f| {f.title => f.id} }.to_json
      @courses = current_user.find_category_abonnements || Course.all
      cookies[:categories] = Course.load_user_cookie current_user
    else
      if cookies[:categories].present?
        @courses = Course.set_courses JSON.parse(cookies[:categories])
      else
        cookies[:categories] = Course.set_new_cookie
        @courses = Course.all
      end
    end
    puts cookies[:categories]
    @categories = JSON.parse cookies[:categories]
  end

  def show
    @course = Course.find(params[:id])
  end

  def destroy
    if Course.delete_course(current_user, params[:id])
      flash[:message] = I18n.t('course.destroy.success')
      redirect_to root_path
    else
      flash[:error] = I18n.t('course.destroy.fail')
      redirect_to root_path
    end
  end

end
