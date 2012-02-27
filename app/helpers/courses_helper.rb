module CoursesHelper

  def attend_course_link
    (current_user.id != @course.user.id) ? (AttendCourse.check_attend_course(current_user.id, @course.id)) : true
  end
end
