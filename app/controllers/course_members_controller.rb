class CourseMembersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_course, :only => [:new_request, :create]
  before_filter :get_course_member, :only => [:show]

  def new_request
    @course_member_conversation = CourseMemberConversation.new
  end

  def show
    @course_member_conversation = CourseMemberConversation.new

    if @course_member.present? && cmc = @course_member.course_member_conversations
      cmc.reject{|cmc| cmc.user == current_user}.all?{|c| c.update_attribute(:unread, :false)}
    end
  end

  def update
    @course_member = CourseMember.find_by_id(params[:id])
    if cm = CourseMember.update_user_acceptance(params[:id], params[:acceptance])
      flash[:info] = I18n.t('course_member.update.success')
    elsif cm == false
      flash[:info] = I18n.t('course_member.update.rejected')
    else
      flash[:error] = I18n.t('course_member.update.fail')
    end
    redirect_to "#{manage_course_path(@course_member.course.id)}/#{@course_member.id}/"
  end

  def destroy
    if course_member = CourseMember.destroy(params[:id])
      flash[:info] = "Du hast deine Begegnungsanfrage erfolgreich abgesagt"
    else
      flash[:error] = "Bei der Absage der Begegnungsanfrage ist ein Fehler aufgetreten"
    end
    redirect_to course_path(course_member.course)
  end

  private

  def get_course
    unless @course = Course.find_by_id(params[:course_id])
      flash[:error] = I18n.t('msg.not_found')
      redirect_to courses_path and return
    end
  end

  def get_course_member
    @course_member = CourseMember.find_by_id(params[:id])
    unless @course_member.user == current_user
      flash[:error] = I18n.t('msg.not_allowed')
      redirect_to courses_path and return
    end
  end
end
