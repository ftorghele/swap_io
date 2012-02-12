class AttendCoursesController < ApplicationController

  def create
    attend_course = AttendCourse.new(:course_id => params[:course_id], :user_id => current_user.id)

    if attend_course.save
      redirect_to courses_path
      flash[:message] = I18n.t('attend_course.create.success')
    else
      redirect_to :back
      flash[:error] = I18n.t('attend_course.create.fail')
    end
  end

end
