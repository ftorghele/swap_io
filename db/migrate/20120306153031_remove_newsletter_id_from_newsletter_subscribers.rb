class RemoveNewsletterIdFromNewsletterSubscribers < ActiveRecord::Migration
  def up
    remove_column :newsletter_subscribers, :newsletter_id
  end

  def down
    add_column :newsletter_subscribers, :newsletter_id, :integer
  end
end
