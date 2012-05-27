class AddCountryToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :country, :string
  end
end
