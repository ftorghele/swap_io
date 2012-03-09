class Course < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :course_members

  validates_presence_of :title, :description, :category_id, :user_id

  def provide_course_mailer course_request_id
    course_request = CourseRequest.find_by_id(course_request_id)
    course_request.users.each do |user|
      user_link = "http://wissenteilen.com/#{I18n.t('routes.users.as')}/#{user.id}"
      course_request_link = "http://wissenteilen.com/#{I18n.t('routes.courses.as')}/#{self.id}"
      SystemMailer.provide_course(user, user_link, course_request_link).deliver
    end
  end

  def course_member_request user
    user_link = "http://wissenteilen.com/#{I18n.t('routes.users.as')}/#{user.id}"
    course_link = "http://wissenteilen.com/#{I18n.t('routes.courses.as')}/#{self.id}"
    SystemMailer.request_course(self.user, user_link, course_link).deliver
  end

  def get_course_members
    self.course_members.all
  end
end
