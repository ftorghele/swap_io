class RenameAssetsToUserImages < ActiveRecord::Migration
  def up
    rename_table :assets, :user_images
  end

  def down
    rename_table :user_images, :assets
  end
end
