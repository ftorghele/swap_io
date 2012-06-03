class CreateUserKeys < ActiveRecord::Migration
  def up
    create_table :user_keys do |t|
      t.string :key

      t.timestamps
    end
  end

  def down
    drop_table :user_keys
  end
end
