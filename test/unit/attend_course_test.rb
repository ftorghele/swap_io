require 'test_helper'

class AttendCourseTest < ActiveSupport::TestCase

  should "be able to attend_course" do
    assert_difference "AttendCourse.count" do
      user = Factory.create(:user)
      course = Factory.create(:course)
      attend_course = Factory.create(:attend_course, :user_id => user.id, :course_id => course.id)
      assert_kind_of AttendCourse, attend_course
    end
  end

  should "check_attend_course for existing user course pairs" do
    user1 =  Factory.create(:user)
    user2 =  Factory.create(:user)
    course =  Factory.create(:course)
    attend_course = Factory.create(:attend_course, :user_id => user1.id, :course_id => course.id)
    assert AttendCourse.check_attend_course(user1, course)
    assert !AttendCourse.check_attend_course(user2, course)
  end

end
