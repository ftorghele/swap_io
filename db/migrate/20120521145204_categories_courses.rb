class CategoriesCourses < ActiveRecord::Migration
  def up

    create_table :categories_courses, :id => false do |t|
      t.references :category, :null => false
      t.references :course, :null => false
    end

    add_index(:categories_courses, [:category_id, :course_id], :unique => true, :name =>'index_categories_courses' )
  end

  def down
    drop_table :categories_courses
  end
end
