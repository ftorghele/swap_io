class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :email
      t.string :signout_hash
      t.string :newsletter_id

      t.timestamps
    end
  end
end
