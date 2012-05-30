class AddCourseRequestIdToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :course_request_id, :integer
  end
end
