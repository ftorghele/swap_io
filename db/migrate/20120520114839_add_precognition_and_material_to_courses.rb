class AddPrecognitionAndMaterialToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :precognitions, :text
    add_column :courses, :materials, :text
  end
end
