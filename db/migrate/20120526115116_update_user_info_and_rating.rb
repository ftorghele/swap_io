class UpdateUserInfoAndRating < ActiveRecord::Migration
  def change
    add_column :users, :fb_user, :boolean, :default => false
    add_column :users, :birthday, :datetime
    add_column :users, :country, :string
    add_column :users, :city, :string

    add_column :users, :course_host_count, :integer, :default => 0
    add_column :users, :course_client_count, :integer, :default => 0

    add_column :users, :rating_pos_count, :integer, :default => 0
    add_column :users, :rating_neut_count, :integer, :default => 0
    add_column :users, :rating_neg_count, :integer, :default => 0

    remove_column :users, :fb_complete
  end
end
