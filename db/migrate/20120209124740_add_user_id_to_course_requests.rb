class AddUserIdToCourseRequests < ActiveRecord::Migration
  def change
    add_column :course_requests, :user_id, :integer

  end
end
