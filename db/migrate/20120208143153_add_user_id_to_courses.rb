class AddUserIdToCourses < ActiveRecord::Migration
  change_table :courses do |t|
    t.integer :user_id
  end
end
