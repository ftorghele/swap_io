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
    assert_raise ActiveRecord::RecordInvalid do
      Factory.create(:course, :user => nil)
    end
  end

  should 'not be valid without category_id' do
    assert_raise ActiveRecord::RecordInvalid do
      Factory.create(:course, :category => nil)
    end
  end

  should 'belong to category' do
    course = Factory.create(:course)
    assert_kind_of Category, course.category
  end

  should 'not be valid without title' do
    assert_no_difference "Course.count" do
      course = Factory.build(:course, :title => "")
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

  should 'provide function create_course' do
    user = Factory.create(:user)
    category = Factory.create(:category)
    params = {"title" => "bli", "description" => "bla", "category_id" => category.id.to_s, "city" => "Salzburg", "zip_code" => "5020", "date" => "2022-05-24 10:38:36", "places" => "10"}
    course = user.courses.new params
    assert course.valid?
  end

  should 'send email to users which joined course_request' do
    user1 = Factory.create(:user)
    user2 = Factory.create(:user)
    course = Factory.create(:course)
    course_request = user1.course_requests.create(:title => "bli", :description => "blup")
    user2.join_course_request(course_request)
    assert_difference "ActionMailer::Base.deliveries.count", 2 do
      course.provide_course_mailer(course_request.id)
    end
  end

  should 'send email to course_request_member' do
    user = Factory.create(:user)
    course = Factory.create(:course)
    assert_difference "ActionMailer::Base.deliveries.count" do
      email_delivery = Course.course_member_request(user, course.id)
      assert_equal ActionMailer::Base.deliveries.last, email_delivery
    end
  end

  should 'send delete email to course_request members' do
    user1 = Factory.create(:user)
    user2 = Factory.create(:user)
    @course = Factory.create(:course)
    Factory.create(:course_member, :user_id => user1.id, :course_id => @course.id)
    Factory.create(:course_member, :user_id => user2.id, :course_id => @course.id)
    assert_difference "ActionMailer::Base.deliveries.count", 2 do
      Course.delete_course(@course.user , @course.id)
    end
  end

  should 'get all course_members' do
    user1 = Factory.create(:user)
    user2 = Factory.create(:user)
    course = Factory.create(:course)
    Factory.create(:course_member, :user_id => user1.id, :course_id => course.id)
    Factory.create(:course_member, :user_id => user2.id, :course_id => course.id)
    assert_equal course.get_course_members.count, 2
  end

  should 'be deletable from owner' do
    user = Factory.create(:user)
    course = Factory.create(:course, :user => user)
    assert_equal course, Course.delete_course(user, course.id)
  end

  should 'not be deletable from other user than owner' do
    user = Factory.create(:user)
    course = Factory.create(:course)
    assert_equal nil, Course.delete_course(user, course.id)
  end

  should 'delete all dependent resources' do
    user1 = Factory.create(:user)
    user2 = Factory.create(:user)
    course = Factory.create(:course)
    assert_difference "CourseMember.count", 2 do
      Factory.create(:course_member, :user_id => user1.id, :course_id => course.id)
      Factory.create(:course_member, :user_id => user2.id, :course_id => course.id)
    end
    assert_difference "CourseMember.count", -2 do
      course.destroy
    end
  end
end
