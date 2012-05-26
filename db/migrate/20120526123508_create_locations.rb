class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|

      t.string :country
      t.string :city
      t.integer :zip_code
      t.float :lat
      t.float :lon
    end
  end
end
