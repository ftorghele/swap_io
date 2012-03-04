require 'test_helper'

class SubscriberTest < ActiveSupport::TestCase

  should 'be able to subscribe' do
    assert_difference "Subscriber.count" do
      Factory.create(:subscriber)
    end
  end

  should 'save valid sha1 hash as signout_hash' do
    subscriber = Factory.create(:subscriber)
    assert_equal subscriber.signout_hash.length, 40
  end

  should 'validate presence of email' do
    assert_no_difference "Subscriber.count" do
      subscriber = Factory.build(:subscriber, :email => nil)
      subscriber.save
    end
  end

  should 'validate presence of signout_hash' do
    assert_no_difference "Subscriber.count" do
      subscriber = Factory.build(:subscriber, :signout_hash => nil)
      subscriber.save
    end
  end

  should 'belong to newsletter' do
    assert_no_difference "Subscriber.count" do
      subscriber = Factory.build(:subscriber, :newsletter_id => nil)
      subscriber.save
    end
  end

  should 'be able to signout from newsletter' do
    subscriber1 = Factory.create(:subscriber)
    subscriber2 = Factory.create(:subscriber, :newsletter_id => subscriber1.newsletter_id)
    assert_difference "ActionMailer::Base.deliveries.count", 2 do
      Newsletter.spread_newsletter
    end
    assert_difference "Subscriber.count", -1 do
      Subscriber.unsubscribe(subscriber2.signout_hash)
    end
    assert_difference "ActionMailer::Base.deliveries.count" do
      Newsletter.spread_newsletter
    end
  end

end
