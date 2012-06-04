class ChangeTypeOfCourseRequestDescription < ActiveRecord::Migration
  def self.up
    change_table :course_requests do |t|
      t.change :description, :text
    end
  end

  def self.down
    change_table :course_requests do |t|
      t.change :description, :string
    end
  end
end
