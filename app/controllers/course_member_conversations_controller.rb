class CourseMemberConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_course, :only => [:create]
  before_filter :get_course_member, :only => [:reply]
  before_filter :create_course_member, :only => [:create]

  def create
    create_or_reply
  end

  def reply
    create_or_reply
  end

  private

  def create_or_reply
    @cmc = @course_member.course_member_conversations.new(params[:course_member_conversation])
    @cmc.user_id = current_user.id

    if @cmc.valid?
      @cmc.save!
      flash[:info] = I18n.t('course_member.create.success')
      redirect_to course_member_path(@course_member)
    else
      flash[:error] = I18n.t('course_member.create.fail')
      render "course_members/new_request"
    end
  end

  def get_course
    unless @course = Course.find_by_id(params[:course_id])
      flash[:error] = I18n.t('msg.not_found')
      redirect_to courses_path and return
    end
  end

  def get_course_member
    unless @course_member = CourseMember.find_by_id(params[:course_member_id])
      flash[:error] = I18n.t('msg.not_found')
      redirect_to courses_path and return
    end
  end

  def create_course_member
    unless @course_member = CourseMember.create(:course_id => @course.id, :user_id => current_user.id)
      flash[:error] = I18n.t('course_member.create.fail')
      redirect_to course_path(@course.id) and return
    else
      Course.course_member_request_mailer current_user, @course.id
    end
  end

end
