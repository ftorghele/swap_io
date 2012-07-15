class CourseRequestUser < ActiveRecord::Base

  default_scope :order => "created_at ASC"

  belongs_to :course_request
  belongs_to :user
end
