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

end
