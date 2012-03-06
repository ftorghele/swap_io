require 'test_helper'

class NewsletterSubscribersControllerTest < ActionController::TestCase

  should "should get right unsubscribe token" do
    subscriber = Factory.create(:newsletter_subscriber)
    assert_difference "NewsletterSubscriber.count", -1 do
      get(:unsubscribe, {'token' => subscriber.signout_hash})
    end
    assert_response :redirect
  end

end
