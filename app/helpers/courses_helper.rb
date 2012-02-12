module CoursesHelper

  def attend_course_link user, course
    (user != @course.user) ? (AttendCourse.check_attend_course(user, course)) ? true : false : false
  end
end
