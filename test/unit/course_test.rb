require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  should 'be able to create course' do
    course = Factory.create(:course)
    assert course.valid?
  end

  should 'belong to user' do
    assert_difference "Course.count" do
      user = Factory.create(:user)
      course = Factory.create(:course, :user => user)
      assert_equal user.id, course.user_id
    end
  end

  should 'not be valid without user_id' do
    assert_no_difference "Course.count" do
      course = Factory.build(:course, :user => nil)
      course.save
      assert !course.valid?
      assert course.errors.count == 1
    end
  end

  should 'not be valid without title' do
    assert_no_difference "Course.count" do
      course = Factory.build(:course)
      course.title = ""
      course.save
    end
  end

  should 'not be valid without description' do
    assert_no_difference "Course.count" do
      course = Factory.build(:course)
      course.description = ""
      course.save
    end
  end

end
