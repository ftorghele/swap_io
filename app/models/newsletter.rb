class Newsletter < ActiveRecord::Base

  validates_presence_of :title, :body

  def self.spread_newsletter(newsletter_id = self.last.id)
    return if self.find(newsletter_id).sent
    newsletter = self.find(newsletter_id)
    Subscriber.find_all_by_newsletter_id(newsletter_id).each do |subscriber|
      SystemMailer.news(subscriber.email, newsletter.body).deliver
    end
    newsletter.sent = true
    newsletter.save
  end

end
