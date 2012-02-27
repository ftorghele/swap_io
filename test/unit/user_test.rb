require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should "be able to create user" do
    assert_difference "User.count" do
      user = Factory.create(:user)
      assert_kind_of User, user
    end
  end

  should "not be able to create user without email" do
    assert_no_difference "User.count" do
      user = Factory.build(:user, :email => "")
      user.save
    end
  end

  should "not be able to create user without password" do
    assert_no_difference "User.count" do
      user = Factory.build(:user, :password => "")
      user.save
    end
  end

  should "not be able to create user without zip" do
    assert_no_difference "User.count" do
      user = Factory.build(:user, :zip => "")
      user.save
      user = Factory.build(:user, :zip => "ABCD")
      user.save
    end
  end

  should "have many courses" do
    assert_difference "Course.count", 2 do
      user   = Factory.create(:user)
      Factory.create(:course, :user_id => user.id)
      Factory.create(:course, :user_id => user.id)
    end
  end

  should "have many course_requests" do
    assert_difference "CourseRequest.count", 2 do
      user =  Factory.create(:user)
      user.course_requests.create(:title => "test", :description => "bli")
      user.course_requests.create(:title => "test", :description => "bliep")
      user.course_requests.each do |f|
        assert_equal f.title, "test"
      end
    end
  end

end
