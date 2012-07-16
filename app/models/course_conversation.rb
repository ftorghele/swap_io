class CourseConversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  default_scope :order => "created_at DESC"

  validates_presence_of :body
end
