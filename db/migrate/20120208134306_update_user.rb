class UpdateUser < ActiveRecord::Migration
  def change
    add_column :users, :description, :text
    add_column :users, :zip, :integer
    remove_column :users, :gender
  end
end
