class CourseMemberConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_course, :only => [:create, :host_reply]
  before_filter :get_course_member, :only => [:reply, :host_reply]
  before_filter :create_course_member, :only => [:create]

  def create
    create_or_reply
    if @cmc.valid?
      @cmc.save!
      flash[:info] = I18n.t('course_member.create.success')
      redirect_to course_member_path(@course_member)
    else
      flash[:error] = I18n.t('course_member.create.fail')
      @course_member_conversation = CourseMemberConversation.new
      render "course_members/new_request"
    end
  end

  def reply
    create_or_reply
    if @cmc.valid?
      @cmc.save!
      flash[:info] = I18n.t('course_member_conversation.reply.success')
      redirect_to course_member_path(@course_member)
    else
      flash[:error] = I18n.t('course_member_conversation.reply.fail')
      redirect_to course_member_path(@course_member)
    end
  end

  def host_reply
    create_or_reply
    if @cmc.valid?
      @cmc.save!
      flash[:info] = I18n.t('course_member_conversation.reply.success')
      redirect_to "#{manage_course_path(@course.id)}/#{@course_member.id}/"
    else
      flash[:error] = I18n.t('course_member_conversation.reply.fail')
      redirect_to "#{manage_course_path(@course.id)}/#{@course_member.id}/"
    end
  end

  private

  def create_or_reply
    @cmc = @course_member.course_member_conversations.new(params[:course_member_conversation])
    @cmc.user_id = current_user.id
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
