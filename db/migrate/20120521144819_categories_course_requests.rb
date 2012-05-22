class CategoriesCourseRequests < ActiveRecord::Migration
  def up

    create_table :categories_course_requests, :id => false do |t|
      t.references :category, :null => false
      t.references :course_request, :null => false
    end

    add_index(:categories_course_requests, [:category_id, :course_request_id], :unique => true , :name =>'index_categories_course_requests' )
  end

  def down
    drop_table :categories_course_requests
  end
end
