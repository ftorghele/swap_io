class Course < ActiveRecord::Base
  include CategorySearch
  include PaperclipProcessors::SharedMethods

  default_scope :order => "#{table_name}.created_at DESC"

  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :course_members, :dependent => :destroy

  has_attached_file :image,
                    :styles => { :thumb => "46x46#", :xsmall => "100x100#", :small => "220x220#", :medium => "300x300#", :big => "800x800>" },
                    :processors => [:cropper]

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_image, :if => :cropping?


  validates_attachment_size :image, :less_than => 5.megabytes


  validates_presence_of :title, :description, :user_id, :date,
                        :time, :places, :city, :zip_code, :country

  attr_accessible :title, :description, :precognitions, :materials, :date,
                  :time, :places, :city, :zip_code, :country, :image, :crop_x, :crop_y, :crop_w, :crop_h,
                  :course_request_id, :category_ids

  validates :zip_code, :numericality => { :only_integer => true }
  validates :places, :numericality => { :only_integer => true }

   validates_presence_of :category_ids
   validates :category_ids, :inclusion => [100], :if => Proc.new { |x|  x.category_ids.count > 3 }

   before_create :initialize_places_available
   before_validation :set_city

  def provide_course_mailer host
    unless self.course_request_id.nil?
      course_request = CourseRequest.find_by_id(self.course_request_id)
      course_request.users.each do |user|
        user_link = "http://wissenteilen.com/#{I18n.t('routes.users.as')}/#{user.id}"
        course_request_link = "http://wissenteilen.com/#{I18n.t('routes.courses.as')}/#{self.id}"
        SystemMailer.provide_course(user, user_link, course_request_link).deliver unless user == host
      end
    end
  end

  def self.delete_course course
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

  def initialize_places_available
    self.places_available = self.places
  end

  def set_city
    location = Location.find_by_country_and_zip_code(self.country, self.zip_code)
    self.city = location.nil? ? "n/a" : location.city
  end
end
