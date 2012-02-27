class RenameAttendCourseToCourseMember < ActiveRecord::Migration
  def up
    rename_table :attend_courses, :course_members
  end

  def down
    rename_table :course_members, :attend_courses
  end
end
