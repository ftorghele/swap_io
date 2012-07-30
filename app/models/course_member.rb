class CourseMember < ActiveRecord::Base

  belongs_to :user
  belongs_to :course

  has_many :course_member_conversations

  attr_accessible :user_id, :course_id

  validates_presence_of :user_id, :course_id
  validates_uniqueness_of :user_id, :scope => :course_id

  def self.check_attendance(user_id, course_id)
    self.exists?(self.find_by_user_id_and_course_id(user_id, course_id))
  end

  def self.update_user_acceptance id, acceptance
    course_member = self.find(id)
    if acceptance == "1"
      if course_member.accepted.to_s != "1"
        course_member.course.places_available -= 1
      end
      SystemMailer.accept_course_member(course_member.user, course_member.course).deliver
    elsif acceptance == "0"
      if course_member.accepted.to_s == "1"
        course_member.course.places_available += 1
      end
      SystemMailer.reject_course_member(course_member.user, course_member.course).deliver
    end
    course_member.update_attribute(:accepted, acceptance)
    course_member.course.save
    acceptance == "1" ? true : false
  end

  def self.course_member_notification_task
    courses = Course.unscoped.find_all_by_date((Time.now - 1.day).strftime("%Y-%m-%d 00:00:00"))
    courses.each do |c|
      c.course_members.each do |cm|
        if cm.accepted.to_s == "1"
          SystemMailer.send_course_member_notification(cm.user, c)
        end
      end
    end
  end
end
