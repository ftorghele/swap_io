class AddJobAndMotivationToUser < ActiveRecord::Migration
  def change
    add_column :users, :job, :string
    add_column :users, :motivation, :string
  end
end
