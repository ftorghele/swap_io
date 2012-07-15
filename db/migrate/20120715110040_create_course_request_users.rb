class CreateCourseRequestUsers < ActiveRecord::Migration
  def change
    rename_table :course_requests_users, :course_request_users

    add_column(:course_request_users, :created_at, :datetime)
    add_column(:course_request_users, :updated_at, :datetime)
  end
end
