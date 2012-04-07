class CourseMember < ActiveRecord::Base

  belongs_to :user
  belongs_to :course

  attr_accessible :user_id, :course_id

  validates_presence_of :user_id, :course_id
  validates_uniqueness_of :user_id, :scope => :course_id

  def self.check_attendance(user_id, course_id)
    self.exists?(self.find_by_user_id_and_course_id(user_id, course_id))
  end

  def self.update_user_acceptance id, acceptance
    course_member = self.find(id)
    course_member.update_attribute(:accepted, acceptance)
    if acceptance == "1"
      SystemMailer.accept_course_member(course_member.user, course_member.course).deliver
    elsif acceptance == "0"
      SystemMailer.reject_course_member(course_member.user, course_member.course).deliver
    end
    acceptance == "1" ? true : false
  end
end
