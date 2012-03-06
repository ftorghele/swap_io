class Newsletter < ActiveRecord::Base

  validates_presence_of :title, :body

  def self.spread_newsletter(newsletter_id = self.first.id)
    newsletter = self.find(newsletter_id)
    NewsletterSubscriber.all.each do |subscriber|
      SystemMailer.news(subscriber.email, newsletter.body).deliver
    end
  end

end
