class RemoveUserIdFromCourseRequests < ActiveRecord::Migration
  def up
    remove_column :course_requests, :user_id
  end

  def down
    add_column :course_requests, :user_id, :integer
  end
end
