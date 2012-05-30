class DropUserImagesTable < ActiveRecord::Migration
  def up
    drop_table :user_images
  end

  def down
    create_table :user_images do |t|
      t.integer :user_id
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
    end
  end
end
