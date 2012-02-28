class AddCategoryIdToCourses < ActiveRecord::Migration

  def change
    add_column :courses, :category_id, :integer, :null => false
  end

end
