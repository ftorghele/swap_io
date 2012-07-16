class CourseConversationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_course, :only => [:create]

  def create
    @course_conversation = @course.course_conversations.build(params[:course_conversation])
    @course_conversation.user_id = current_user.id
    if @course_conversation.valid?
      @course_conversation.save!
      flash[:info] = I18n.t('course_conversations.create.success')
      redirect_to course_path(@course)
    else
      flash[:error] = I18n.t('course_conversations.create.fail')
      render "courses/show"
    end
  end

  private

  def get_course
    unless @course = Course.unscoped.find_by_id(params[:course_id])
      flash[:error] = I18n.t('msg.not_found')
      redirect_to courses_path and return
    end
  end

end
