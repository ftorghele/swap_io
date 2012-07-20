module CoursesHelper

  def attend_course_link
    (current_user.id != @course.user.id) ? (CourseMember.check_attendance(current_user.id, @course.id)) : true
  end

  def places_available?( course )
    (course.places_available <= 0) ? false : true
  end

  def categories(cat)
    @course ? @course.categories.include?(cat) : false
  end
end
