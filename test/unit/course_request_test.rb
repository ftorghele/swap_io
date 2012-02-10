require 'test_helper'

class CourseRequestTest < ActiveSupport::TestCase

  should 'be able to create course_request' do
    course_request = Factory.create(:course_request)
    assert course_request.valid?
  end

  should 'belong to user' do
    assert_difference "CourseRequest.count" do
      user = Factory.create(:user)
      course_request = Factory.create(:course_request, :user => user)
      assert_equal user.id, course_request.user_id
    end
  end

  should 'not be valid without user_id' do
    assert_raise ActiveRecord::StatementInvalid do
      Factory.create(:course_request, :user => nil)
    end
  end

  should 'not be valid without title' do
    assert_no_difference "CourseRequest.count" do
      course_request = Factory.build(:course_request, :title => "")
      course_request.save
    end
  end

  should 'not be valid without description' do
    assert_no_difference "CourseRequest.count" do
      course_request = Factory.build(:course_request)
      course_request.description = ""
      course_request.save
    end
  end
end
