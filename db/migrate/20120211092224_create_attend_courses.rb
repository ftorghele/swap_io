class CreateAttendCourses < ActiveRecord::Migration
  def change
    create_table :attend_courses do |t|
      t.integer :user_id, :null => false
      t.integer :course_id, :null => false
      t.boolean :accepted, :default => false
      t.timestamps
    end
  end
end
