class ChangeAcceptedFromCourseMember < ActiveRecord::Migration
  def up
    change_column :course_members, :accepted, :integer, :default => 2
  end

  def down
    change_column :course_members, :accepted, :boolean, :default => false
  end
end
