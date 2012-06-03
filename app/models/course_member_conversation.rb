class CourseMemberConversation < ActiveRecord::Base
  attr_accessible :user_id, :course_member_id, :body

  validates_presence_of :user_id, :course_member_id, :body

  belongs_to :user
  belongs_to :course_member
end
