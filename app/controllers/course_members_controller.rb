class CourseMembersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_course, :only => [:new_request, :create]

  def new_request
    @course_member_conversation = CourseMemberConversation.new
  end

  def show
    @course_member = CourseMember.find_by_id(params[:id])
    @course_member_conversation = CourseMemberConversation.new
  end

  def update
    if course_member = CourseMember.update_user_acceptance(params[:id], params[:acceptance])
      flash[:info] = I18n.t('course_member.update.success')
    elsif course_member == false
      flash[:info] = I18n.t('course_member.update.rejected')
    else
      flash[:error] = I18n.t('course_member.update.fail')
    end
    redirect_to root_path
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
      puts @course.inspect
      flash[:error] = I18n.t('msg.not_found')
      redirect_to courses_path and return
    end
  end
end
