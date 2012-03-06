class AddSentToNewsletter < ActiveRecord::Migration
  def change
    add_column :newsletters, :sent, :boolean, :default => 0

  end
end
