require 'test_helper'

class CourseMembersTest < ActiveSupport::TestCase

  should "be able to attend course" do
    assert_difference "CourseMember.count" do
      user = Factory.create(:user)
      course = Factory.create(:course)
      attendance = Factory.create(:course_member, :user_id => user.id, :course_id => course.id)
      assert_kind_of CourseMember, attendance
    end
  end

  should "check_course_member for existing user course pairs" do
    user1 =  Factory.create(:user)
    user2 =  Factory.create(:user)
    course =  Factory.create(:course)
    attendance = Factory.create(:course_member, :user_id => user1.id, :course_id => course.id)
    assert CourseMember.check_attendance(user1, course)
    assert !CourseMember.check_attendance(user2, course)
  end

end
