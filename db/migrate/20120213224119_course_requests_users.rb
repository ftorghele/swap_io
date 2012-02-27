class CourseRequestsUsers < ActiveRecord::Migration
  def up
    create_table :course_requests_users, :id => false do |t|
      t.references :user, :null => false
      t.references :course_request, :null => false
    end

    add_index(:course_requests_users, [:user_id, :course_request_id], :unique => true)
  end

  def down
    drop_table :course_requests_users
  end

end
