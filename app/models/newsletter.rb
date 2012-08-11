class Newsletter < ActiveRecord::Base

  validates_presence_of :title, :body

  def self.spread_newsletter(newsletter_id = self.last.id)
    return if self.find(newsletter_id).sent
    newsletter = self.find(newsletter_id)
    NewsletterSubscriber.all.each do |subscriber|
      begin
        SystemMailer.news(subscriber.email, newsletter.body).deliver
      rescue
      end
    end
    newsletter.update_attribute(:sent, true)
  end

end
