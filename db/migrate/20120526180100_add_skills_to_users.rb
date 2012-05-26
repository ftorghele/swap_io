class AddSkillsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :skills, :text
    drop_table :user_skills
  end
end
