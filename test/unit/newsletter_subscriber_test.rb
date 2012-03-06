require 'test_helper'

class NewsletterSubscriberTest < ActiveSupport::TestCase

  should 'be able to subscribe' do
    assert_difference "NewsletterSubscriber.count" do
      Factory.create(:newsletter_subscriber)
    end
  end

  should 'save valid sha1 hash as signout_hash' do
    subscriber = Factory.create(:newsletter_subscriber)
    assert_equal subscriber.signout_hash.length, 40
  end

  should 'validate presence of email' do
    assert_no_difference "NewsletterSubscriber.count" do
      subscriber = Factory.build(:newsletter_subscriber, :email => nil)
      subscriber.save
    end
  end

  should 'validate presence of signout_hash' do
    assert_no_difference "NewsletterSubscriber.count" do
      subscriber = Factory.build(:newsletter_subscriber, :signout_hash => nil)
      subscriber.save
    end
  end

  should 'be able to signout from newsletter' do
    newsletter = Factory.create(:newsletter)
    subscriber1 = Factory.create(:newsletter_subscriber)
    subscriber2 = Factory.create(:newsletter_subscriber)
    assert_difference "ActionMailer::Base.deliveries.count", 2 do
      Newsletter.spread_newsletter(newsletter.id)
    end
    assert_difference "NewsletterSubscriber.count", -1 do
      NewsletterSubscriber.unsubscribe(subscriber2.signout_hash)
    end
    assert_difference "ActionMailer::Base.deliveries.count" do
      Newsletter.spread_newsletter
    end
  end

end
