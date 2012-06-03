class CreateUserKeys < ActiveRecord::Migration
  def change
    create_table :user_keys do |t|
      t.string :key

      t.timestamps
    end
  end
end
