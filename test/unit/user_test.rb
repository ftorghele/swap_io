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
      user = Factory.build(:user)
      user.email = ""
      user.save

      assert user.errors.count == 1
    end
  end

  should "not be able to create user without password" do
    assert_no_difference "User.count" do
      user = Factory.build(:user)
      user.password = ""
      user.save
    end
  end

  should "have many courses" do
    assert_difference "Course.count" do
      user = Factory.create(:user)
      course = Factory.create(:course, :user_id => user.id)
    end
  end


end
