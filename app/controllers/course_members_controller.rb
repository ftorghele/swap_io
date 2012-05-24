class CourseMembersController < ApplicationController

  before_filter :authenticate_user!

  def create
    course_id = params[:course_id]
    if CourseMember.create(:course_id => course_id, :user_id => current_user.id)
      Course.course_member_request current_user, course_id
      flash[:info] = I18n.t('course_member.create.success')
      redirect_to courses_path
    else
      flash[:error] = I18n.t('course_member.create.fail')
      redirect_to course_path(course_id)
    end
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
end
