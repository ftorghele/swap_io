require 'test_helper'

class NewsletterTest < ActiveSupport::TestCase

  should 'be able to create newsletter' do
    Factory.create(:newsletter)
  end

  should 'validate presence of title' do
    assert_no_difference "Newsletter.count" do
      newsletter = Factory.build(:newsletter, :title => nil)
      newsletter.save
    end
  end

  should 'validate presence of body' do
    assert_no_difference "Newsletter.count" do
      newsletter = Factory.build(:newsletter, :body => nil)
      newsletter.save
    end
  end

  should 'send email to subscribers' do
    newsletter = Factory.create(:newsletter)
    subscriber1 = Factory.create(:newsletter_subscriber)
    subscriber2 = Factory.create(:newsletter_subscriber)
    assert_difference "ActionMailer::Base.deliveries.count", 2 do
      Newsletter.spread_newsletter
    end
  end

  should 'send email to subscribers only once' do
    newsletter = Factory.create(:newsletter)
    subscriber = Factory.create(:newsletter_subscriber)
    assert_difference "ActionMailer::Base.deliveries.count" do
      Newsletter.spread_newsletter
    end
    newsletter.sent = true
    newsletter.save
    assert_no_difference "ActionMailer::Base.deliveries.count" do
      Newsletter.spread_newsletter
    end
  end

end
