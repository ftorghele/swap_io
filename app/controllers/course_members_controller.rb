class CourseMembersController < ApplicationController

  def create
    course_id = params[:course_id]
    if CourseMember.create(:course_id => course_id, :user_id => current_user.id)
      Course.course_member_request current_user, course_id
      flash[:message] = I18n.t('course_member.create.success')
      redirect_to courses_path
    else
      flash[:error] = I18n.t('course_member.create.fail')
      redirect_to :back
    end
  end

  def update
    if course_member = CourseMember.update_user_acceptance(params[:id], params[:acceptance])
      flash[:message] = I18n.t('course_member.update.success')
    elsif course_member == false
      flash[:message] = I18n.t('course_member.update.rejected')
    else
      flash[:error] = I18n.t('course_member.update.fail')
    end
    redirect_to :back
  end
end
