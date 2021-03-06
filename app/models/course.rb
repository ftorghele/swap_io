class Course < ActiveRecord::Base
  include CategorySearch
  include PaperclipProcessors::SharedMethods

  default_scope :order => "#{table_name}.date ASC", :conditions => ["courses.date >= ?", Time.now]

  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :course_members, :dependent => :destroy
  has_many :course_conversations, :dependent => :destroy

  has_attached_file :image,
                    :styles => { :thumb => "46x46#", :xsmall => "100x100#", :small => "220x220#", :medium => "300x300#", :big => "800x800>" },
                    :processors => [:cropper],
                    :default_url => "/assets/begegnungen/:style.png"

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
  validate :date_check

  validates_presence_of :category_ids
  validates :category_ids, :inclusion => [100], :if => Proc.new { |x|  x.category_ids.count > 3 }

  before_create :initialize_places_available
  before_validation :set_city

  def provide_course_mailer host
    unless self.course_request_id.nil?
      course_request = CourseRequest.find_by_id(self.course_request_id)
      course_request.users.each do |user|
        @user = User.find(user.id)
        @user.push_message
        @host = host
        unless user == host
          msg = "Dein Begegnungswunsch! \n\n Hallo #{@user.first_name}!\n #{@host.first_name} hat auf wissenteilen.com auf Deinen Begegnungswunsch reagiert.\n Details zur Person und der Begegnung findest du unter folgenden Links: \n Profil von #{@host.first_name} ansehen: http://wissenteilen.com/mitglied/#{@host.id}\n Deine Begegnung verwalten: http://wissenteilen.com/begegnungen/#{self.id}\n\n Dein Wissen Teilen\nTeam"
          receipt = self.user.send_message(user, msg,  I18n.t('mailer.subject.provide_course'))
          if (receipt.errors.blank?)
            @conversation = receipt.conversation
          end
          SystemMailer.provide_course(user, host, self).deliver
        end
      end
    end
  end

  def self.delete_course course
    course.get_course_members.each do |member|
      member.user.push_message
      SystemMailer.delete_course(member.user, course).deliver
    end
    course.destroy
  end

  def self.course_member_request_mailer requester, id
    course = self.find_by_id(id)
    course.user.push_message
    SystemMailer.request_course(course.user, requester, course).deliver
  end

  def get_course_members
    self.course_members.all
  end

  def get_unread_course_member_conversations course_members, current_user
    return nil if course_members.nil?
    cmc = course_members.collect{|cm| cm.course_member_conversations}.flatten
    cmc.empty? ? nil : cmc.reject{|cmc| cmc.user == current_user || cmc.unread == false}
  end

  def get_accepted_course_members
    self.course_members.find_all_by_accepted(1)
  end

  def get_refused_course_members
    self.course_members.find_all_by_accepted(0)
  end

  def get_open_course_members
    self.course_members.find_all_by_accepted(2)
  end

  def initialize_places_available
    self.places_available = self.places
  end

  def set_city
    location = Location.find_by_country_and_zip_code(self.country, self.zip_code)
    self.city = location.nil? ? "n/a" : location.city
  end

  def get_course_request_count
    self.course_members.find_all_by_accepted(2).count
  end

  private

  def date_check
    self.errors.add(:date, "Datum ist bereits vorbei") unless self.date.future?
  end
end
