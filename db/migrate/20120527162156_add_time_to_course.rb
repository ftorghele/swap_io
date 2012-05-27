class AddTimeToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :time, :time
  end
end
