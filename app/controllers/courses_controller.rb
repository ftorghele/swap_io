class CoursesController < ApplicationController
  require 'json'

  before_filter :authenticate_user!   , :only => [:new, :create, :destroy]
  before_filter :get_course, :only => [:show, :edit, :update, :destroy, :manage]
  before_filter :check_user, :only => [:edit, :update, :destroy, :manage]
  before_filter :get_course_member, :only => [:manage]

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
    @course_conversation = @course.course_conversations.build
  end

  def show_past_courses
    if signed_in?
      @courses = Course.unscoped.find(:all, :conditions => ["date < ? && user_id = ?",Time.now.to_date, current_user.id ] )
    end
  end

  def new
    @course = Course.new
  end

  def new_with_course
    if course = Course.unscoped.find_by_id(params[:course_id])
      cat = []
      course.categories.map{|f| cat << f.id.to_s }
      @course = Course.new( :title => course.title,
                            :description => course.description,
                            :category_ids => cat,
                            :city => course.city,
                            :places => course.places,
                            :zip_code => course.zip_code,
                            :precognitions => course.precognitions,
                            :materials => course.materials,
                            :country => course.country,
                            :course_request_id => course.course_request_id )
    else
      @course = Course.new
    end
    render :new
  end

  def new_with_request
    if @course_request = CourseRequest.find_by_id(params[:request_id])
      cat = []
      @course_request.categories.map{|f| cat << f.id.to_s }
      @course = Course.new( :title => @course_request.title,
                            :description => @course_request.description,
                            :category_ids => cat,
                            :course_request_id => @course_request.id )
    else
      @course = Course.new
    end
    render :new
  end

  def edit
  end

  def manage
    @course_member_conversation = CourseMemberConversation.new

    if @course_member.present? && cmc = @course_member.course_member_conversations
      cmc.reject{|cmc| cmc.user == current_user}.all?{|c| c.update_attribute(:unread, :false)}
    end
  end

  def create
    @course = current_user.courses.new( params[:course] )
    if @course.valid?
      @course.save!
      flash[:info] = I18n.t('course.create.success')
      @course.provide_course_mailer(current_user)
      if params[:course][:image].blank? || params[:javascript].blank?
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
      if params[:course][:image].blank? || params[:javascript].blank?
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
    unless @course = Course.unscoped.find_by_id(params[:id])
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

  def get_course_member
    unless params[:course_member_id].nil?
      @course_member = CourseMember.find_by_id(params[:course_member_id])
      unless @course.course_members.include?(@course_member)
        flash[:error] = I18n.t('msg.not_allowed')
        redirect_to courses_path and return
      end
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
