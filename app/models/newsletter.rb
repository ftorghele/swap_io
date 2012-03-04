class Newsletter < ActiveRecord::Base

  has_many :subscribers

  validates_presence_of :title, :body

  def self.spread_newsletter(newsletter_id = self.first.id)
    newsletter = self.find(newsletter_id)
    Subscriber.find_all_by_newsletter_id(newsletter_id).each do |subscriber|
      SystemMailer.news(subscriber.email, newsletter.body).deliver
    end
  end

end
