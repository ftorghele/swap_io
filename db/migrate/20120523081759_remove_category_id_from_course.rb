class RemoveCategoryIdFromCourse < ActiveRecord::Migration
  def up
    remove_column :courses, :category_id
  end

  def down
    add_column :courses, :category_id, :integer
  end
end
