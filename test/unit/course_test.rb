require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  should "list all courses" do
    course = Factory.create(:course)
    assert_not_nil Course.get_courses
    assert_instance_of Course, Course.get_courses.first
  end

  # should "not create course without title" do
  #   assert_difference "Course.count" do
  #   end
  # end

  # should "not create course without description" do
  #   assert_difference "Course.count" do
  #   end
  # end

end
