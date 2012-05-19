class Course < ActiveRecord::Base

  default_scope :order => "created_at DESC"

  belongs_to :user
  belongs_to :category
  has_many :course_members, :dependent => :destroy

  validates_presence_of :title, :description, :category_id, :user_id, :date,
                        :places, :city, :zip_code

  validates :zip_code, :numericality => { :only_integer => true }
  validates :places, :numericality => { :only_integer => true }

  before_create :initialize_places_available

  def provide_course_mailer course_request_id
    course_request = CourseRequest.find_by_id(course_request_id)
    course_request.users.each do |user|
      user_link = "http://wissenteilen.com/#{I18n.t('routes.users.as')}/#{user.id}"
      course_request_link = "http://wissenteilen.com/#{I18n.t('routes.courses.as')}/#{self.id}"
      SystemMailer.provide_course(user, user_link, course_request_link).deliver
    end
  end

  def self.delete_course user, id
    course = self.find(id)
    return unless user.id == course.user_id
    course.get_course_members.each do |member|
      SystemMailer.private_message(member.user, I18n.t('course.destroy.subject'),
                  I18n.t('course.destroy.body', :name => "#{member.user.first_name} #{member.user.last_name}") ).deliver
    end
    course.destroy
  end

  def self.course_member_request user, id
    course = self.find_by_id(id)
    user_link = "http://wissenteilen.com/#{I18n.t('routes.users.as')}/#{user.id}"
    course_link = "http://wissenteilen.com/#{I18n.t('routes.courses.as')}/#{course.id}"
    SystemMailer.request_course(course.user, user_link, course_link).deliver
  end

  def get_course_members
    self.course_members.all
  end

  private

  def initialize_places_available
    self.places_available = self.places
  end
end
