class Subscriber < ActiveRecord::Base

  belongs_to :newsletter

  validates_presence_of :email, :signout_hash, :newsletter_id
  validates :email, :presence => true, :email => true

  def self.unsubscribe(token)
    subscriber = self.find_by_signout_hash(token)
    subscriber.destroy
  end

end
