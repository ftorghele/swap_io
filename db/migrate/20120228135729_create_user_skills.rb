class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|

      t.string :title
      t.integer :user_id
      t.timestamps
    end
  end
end
