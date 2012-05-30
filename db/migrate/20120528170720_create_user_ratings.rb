class CreateUserRatings < ActiveRecord::Migration
  def change
    create_table :user_ratings do |t|
      t.integer :user_id, :null => false
      t.integer :evaluator_id, :null => false
      t.string :rating, :null => false
      t.text :body, :null => false

      t.timestamps
    end
  end
end
