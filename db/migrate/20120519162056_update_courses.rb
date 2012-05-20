class UpdateCourses < ActiveRecord::Migration
  def change
    add_column :courses, :date, :datetime, :null => false
    add_column :courses, :places, :integer, :null => false
    add_column :courses, :places_available, :integer, :null => false
    add_column :courses, :city, :string, :null => false
    add_column :courses, :zip_code, :integer, :null => false
  end
end
