class RenameSubscribersToNewsletterSubscribers < ActiveRecord::Migration
  def up
    rename_table :subscribers, :newsletter_subscribers
  end

  def down
    rename_table :newsletter_subscribers, :subscribers
  end
end
