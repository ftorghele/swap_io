class NewsletterSubscriber < ActiveRecord::Base

  validates_presence_of :email, :signout_hash
  validates :email, :presence => true, :email => true
  validates_uniqueness_of :email

  def self.unsubscribe(token)
    subscriber = self.find_by_signout_hash(token)
    subscriber.destroy
  end

end
