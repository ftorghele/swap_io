require 'test_helper'

class SubscribersControllerTest < ActionController::TestCase

  should "should get right unsubscribe token" do
    subscriber = Factory.create(:subscriber)
    assert_difference "Subscriber.count", -1 do
      get(:unsubscribe, {'token' => subscriber.signout_hash})
    end
    assert_response :redirect
  end

end
