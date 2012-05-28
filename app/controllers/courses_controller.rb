class CoursesController < ApplicationController
  require 'json'

  before_filter :authenticate_user! , :only => [:new, :create, :destroy]
  before_filter :get_course, :only => [:show, :edit, :update, :destroy]
  before_filter :check_user, :only => [:edit, :update, :destroy]

  def index
    if signed_in?
      @courses = Course.find_category_abonnements(current_user, true)
      cookies[:categories] = Course.load_user_cookie current_user
    else
      if cookies[:categories].present?
        @courses = Course.set_courses JSON.parse(cookies[:categories])
      else
        cookies[:categories] = Course.set_new_cookie
        @courses = Course.all
      end
    end
    @categories = JSON.parse cookies[:categories]
  end

  def show
  end

  def new
      @course = Course.new
  end

  def edit
  end

  def create
    @course = current_user.courses.new( params[:course] )
    if @course.valid?
      @course.save!
      flash[:info] = I18n.t('course.create.success')
      @course.provide_course_mailer params[:type] if params[:type]
      if params[:course][:image].blank?
        redirect_to course_path(@course)
      else
        render "shared/crop", :locals => {:obj => @course}
      end
    else
      flash_right_error
      render :new
    end
  end

  def update
    @course.update_attributes(params[:course])
    if @course.valid?
      @course.save!
      flash[:info] = I18n.t('course.update.success')
      if params[:course][:image].blank?
        redirect_to course_path(@course)
      else
        render "shared/crop", :locals => {:obj => @course}
      end
    else
      flash_right_error
      render :action => :edit
    end
  end

  def destroy
    if Course.delete_course(@course)
      flash[:info] = I18n.t('course.destroy.success')
      redirect_to root_path
    else
      flash[:error] = I18n.t('course.destroy.fail')
      redirect_to course
    end
  end

  private

  def get_course
    unless @course = Course.find_by_id(params[:id])
      flash[:error] = I18n.t('msg.not_found')
      redirect_to courses_path and return
    end
  end

  def check_user
    unless @course.user == current_user
      flash[:error] = I18n.t('msg.not_allowed')
      redirect_to courses_path and return
    end
  end

  def flash_right_error
    cat_array = params[:course][:category_ids]
    if cat_array.nil? || cat_array.empty?
      flash[:error] = I18n.t('course.msg.no_categories')
    elsif cat_array.count > 3
      flash[:error] = I18n.t('course.msg.too_much_categories')
    else
      flash[:error] = I18n.t('course.msg.fail')
    end
  end
end
