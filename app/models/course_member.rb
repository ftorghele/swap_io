class CourseMember < ActiveRecord::Base

  has_one :user
  has_one :course

  belongs_to :user
  belongs_to :course

  attr_accessible :user_id, :course_id

  validates_presence_of :user_id, :course_id
  validates_uniqueness_of :user_id, :scope => :course_id

  def self.check_attendance(user_id, course_id)
    self.exists?(self.find_by_user_id_and_course_id(user_id, course_id))
  end

end
