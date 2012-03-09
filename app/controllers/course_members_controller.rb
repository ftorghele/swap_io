class CourseMembersController < ApplicationController

  def create
    course_id = params[:course_id]
    course_member = CourseMember.new(:course_id => course_id, :user_id => current_user.id)
    course = Course.find(course_id)

    if course_member.save
      redirect_to courses_path
      flash[:message] = I18n.t('course_member.create.success')
      course.course_member_request current_user
    else
      redirect_to :back
      flash[:error] = I18n.t('course_member.create.fail')
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
