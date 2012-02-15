require 'test_helper'

class CourseRequestTest < ActiveSupport::TestCase

  should 'be able to create course_request' do
    course_request = Factory.create(:course_request)
    assert course_request.valid?
  end

  should 'belong to user' do
    user = Factory.create(:user)
    assert_respond_to user, :course_requests
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
