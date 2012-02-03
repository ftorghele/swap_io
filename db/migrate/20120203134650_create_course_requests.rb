class CreateCourseRequests < ActiveRecord::Migration
  def change
    create_table :course_requests do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
