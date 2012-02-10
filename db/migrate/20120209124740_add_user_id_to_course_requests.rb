class AddUserIdToCourseRequests < ActiveRecord::Migration
  def change
    add_column :course_requests, :user_id, :integer, :null => false
  end
end
