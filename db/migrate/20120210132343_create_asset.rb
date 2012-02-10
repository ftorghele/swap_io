class CreateAsset < ActiveRecord::Migration
  def change
    create_table :assets do |t|

      t.integer :user_id

      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
    end
  end
end