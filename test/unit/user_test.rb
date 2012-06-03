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

  should "have job field" do
    assert_difference "User.count" do
      user = Factory.create(:user, :job => "Computerer")
      assert_equal user.job, "Computerer"
    end
  end

  should "have motivation field" do
    assert_difference "User.count" do
      user = Factory.create(:user, :motivation => "motivation...field")
      assert_equal user.motivation, "motivation...field"
    end
  end

  should "have many courses" do
    assert_difference "Course.count", 2 do
      user   = Factory.create(:user)
      course1 = Factory.build(:course, :user_id => user.id)
      course1.categories << Factory.create(:category)
      course1.save
      course2 = Factory.build(:course, :user_id => user.id)
      course2.categories << Factory.create(:category)
      course2.save
    end
  end

  should "have many course_requests" do
    assert_difference "CourseRequest.count", 2 do
      user =  Factory.create(:user)
      course_request1 = Factory.build(:course_request, :title => "test")
      course_request1.categories << Factory.create(:category)
      course_request1.users << user
      course_request1.save
      course_request2 = Factory.build(:course_request, :title => "test")
      course_request2.categories << Factory.create(:category)
      course_request2.users << user
      course_request2.save
      user.course_requests.each do |f|
        assert_equal f.title, "test"
      end
    end
  end

  context "course_request_exist?" do
    should "find existing course_request" do
      user =  Factory.create(:user)
      course_request = Factory.build(:course_request)
      course_request.categories << Factory.create(:category)
      course_request.users << user
      course_request.save
      assert_equal true, user.has_course_request?(course_request)
    end

    should "not find course_requests of other users" do
      user =  Factory.create(:user)
      user2 =  Factory.create(:user)
      course_request = Factory.build(:course_request)
      course_request.categories << Factory.create(:category)
      course_request.save
      assert_equal false, user2.has_course_request?(course_request)
    end
  end

  context "join_course_request" do
    should "join_course_request if not already joined" do
      user =  Factory.create(:user)
      course_request = Factory.build(:course_request)
      course_request.categories << Factory.create(:category)
      course_request.save
      assert_equal [course_request], user.join_course_request(course_request)
      assert_equal false, user.join_course_request(course_request)
    end
  end

  context 'disjoin_course_request' do
    should 'disjoin course request for last user correct' do
      user = Factory.create(:user)
      course_request = Factory.build(:course_request)
      course_request.categories << Factory.create(:category)
      course_request.save
      user.join_course_request(course_request)
      assert_not_nil course_request
      user.disjoin_course_request(course_request)
      assert CourseRequest.find_by_id(course_request.id).nil?
    end

    should 'not delete course request for last user' do
      user1 = Factory.create(:user)
      user2 = Factory.create(:user)
      course_request = Factory.build(:course_request)
      course_request.categories << Factory.create(:category)
      course_request.save
      user1.join_course_request(course_request)
      user2.join_course_request(course_request)
      user1.disjoin_course_request(course_request)
      assert_not_nil CourseRequest.find_by_id(course_request.id)
    end

    should 'not be able to disjoin course request twice' do
      user1 = Factory.create(:user)
      user2 = Factory.create(:user)
      course_request = Factory.build(:course_request)
      course_request.categories << Factory.create(:category)
      course_request.save
      user1.join_course_request(course_request)
      user2.join_course_request(course_request)
      user1.disjoin_course_request(course_request)
      user1.disjoin_course_request(course_request)
      assert_not_nil CourseRequest.find_by_id(course_request.id)
    end
  end

  should 'get all courses of a user' do
    user = Factory.create(:user)
    course1 = Factory.build(:course, :user => user)
    course2 = Factory.build(:course, :user => user)
    course1.categories << Factory.create(:category)
    course1.save!
    course2.categories << Factory.create(:category)
    course2.save!
    assert_equal user.get_courses.count, 2
  end

  should 'get all course_requests of a user' do
    user = Factory.create(:user)
    course_request1 = Factory.build(:course_request)
    course_request1.categories << Factory.create(:category)
    course_request1.save
    course_request2 = Factory.build(:course_request)
    course_request2.categories << Factory.create(:category)
    course_request2.save
    user.join_course_request(course_request1)
    user.join_course_request(course_request2)
    assert_equal user.get_course_requests.count, 2
  end

  should 'get all accepted course_memberships of a user' do
    user = Factory.create(:user)
    course1 = Factory.build(:course)
    course2 = Factory.build(:course)
    course1.categories << Factory.create(:category)
    course1.save!
    course2.categories << Factory.create(:category)
    course2.save!
    Factory.create(:course_member, :user_id => user.id, :course_id => course1.id, :accepted => 1)
    Factory.create(:course_member, :user_id => user.id, :course_id => course2.id, :accepted => 1)
    assert_equal 2, user.get_course_memberships.count
  end

  should 'delete all dependent resources' do
    user1 = Factory.create(:user)
    user2 = Factory.create(:user)
    user3 = Factory.create(:user)
    course = Factory.build(:course, :user => user3)
    course.categories << Factory.create(:category)
    course.save!
    assert_difference "CourseMember.count", 2 do
      Factory.create(:course_member, :user => user1, :course => course)
      Factory.create(:course_member, :user => user2, :course => course)
    end
    assert_difference "Course.count", -1 do
      user3.destroy
    end
    assert_equal CourseMember.count, 0
  end
end
