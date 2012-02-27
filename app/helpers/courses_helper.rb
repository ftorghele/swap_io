module CoursesHelper

  def attend_course_link
    (current_user.id != @course.user.id) ? (CourseMember.check_attendance(current_user.id, @course.id)) : true
  end
end
