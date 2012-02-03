require 'integration_test_helper'

class CourseTest < ActionDispatch::IntegrationTest

  should 'show course request overview' do
    course_request1 = Factory.create(:course_request)
    course_request2 = Factory.create(:course_request)

    visit "/course_requests"


    assert page.has_content?(course_request1.title)
    assert page.has_content?(course_request1.description)
    assert page.has_content?(course_request2.title)
    assert page.has_content?(course_request2.description)
  end

end
