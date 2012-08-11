class User < ActiveRecord::Base
  include PaperclipProcessors::SharedMethods

  acts_as_messageable

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me,
                  :first_name, :last_name, :zip, :confirmed_at, :user_images_attributes,
                  :description, :skills, :job, :motivation, :birthday, :user_key,
                  :country, :city, :fb_user, :image, :crop_x, :crop_y, :crop_w, :crop_h

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :zip
  validates_presence_of :country
  validates_presence_of :city

#   validates_presence_of :user_key
#   if ActiveRecord::Base.connection.tables.include?("user_keys")
#     validates_inclusion_of :user_key, :in => UserKey.all.empty? ? [] : UserKey.all.collect{|i| i.key.to_s}.to_enum,  :message => "Dieser Code ist uns leider nicht bekannt"
#   end

  validates :zip, :numericality => { :only_integer => true }

  has_many :courses, :dependent => :destroy
  has_many :course_members, :through => :courses, :dependent => :destroy
  has_many :course_conversations, :dependent => :destroy
  has_many :category_abonnements, :dependent => :destroy
  has_many :user_ratings, :dependent => :destroy
  has_many :course_member_conversations, :dependent => :destroy

  has_many :course_request_users
  has_many :course_requests, :through => :course_request_users

  has_attached_file :image,
                    :styles => { :thumb => "46x46#", :xsmall => "32x32#", :small => "60x60#", :medium => "300x300#", :big => "800x800>" },
                    :processors => [:cropper],
                    :default_url => "/assets/user/:style.png"

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_image, :if => :cropping?

  validates_attachment_size :image, :less_than => 5.megabytes



  before_validation :set_city

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else
      user = User.new(:email => data.email,
                      :first_name => data.first_name,
                      :last_name => data.last_name,
                      :fb_user => true)
      user
    end
  end

  def has_course_request?(course_request)
    self.course_requests.find_by_id(course_request.id) ? true : false
  end

  def join_course_request(course_request)
    self.has_course_request?(course_request) ? false : self.course_requests << course_request
  end

  def disjoin_course_request(course_request)
    if CourseRequest.find_by_id(course_request.id).users.count > 1
      self.course_requests.delete(course_request)
    else
      CourseRequest.find_by_id(course_request.id).destroy if self.has_course_request?(course_request)
    end
  end

  def get_age
    now = Time.now.utc.to_date
    age = now.year - self.birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0) unless self.birthday.nil?
    age
  end

  def get_courses
    self.courses.where("date > #{Time.now.to_date}")
  end

  def get_old_courses
    Course.unscoped.find(:all, :conditions => ["date < ? && user_id = ?",Time.now.to_date, self.id ] )
  end

  def get_enquired_courses
    get_course_memberships.map{|i| i.course}
  end

  def get_course_requests
    self.course_requests
  end

  def get_course_memberships
    CourseMember.find_all_by_user_id(self.id)
  end

  def toggle_category_abonnements category
    if category_abonnement = self.category_abonnements.find_by_category_id(category.id)
      category_abonnement.destroy
    else
      self.category_abonnements.create(:category => category)
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def mailboxer_email(object)
    self.push_message
    email
  end

  def get_unread_message_count
    self.receipts.reject{|i| i.read}.count
  end

  def get_courses_requests_count
    self.courses.sum{|c| c.get_course_request_count}
  end

  def get_course_members
    CourseMember.find_all_by_course_id(self.courses.collect{|course| course.id})
  end

  def get_unread_course_member_conversations course_members
    return nil if course_members.empty?
    cmc = course_members.collect{|cm| cm.course_member_conversations}.flatten
    cmc.empty? ? nil : cmc.reject{|cmc| cmc.user == self || cmc.unread == false}
  end

  def get_unread_course_member_conversations_count
    cmc = []
    cmc << get_unread_course_member_conversations(get_course_members) << get_unread_course_member_conversations(get_course_memberships)
    cmc.flatten!
    cmc.reject!{|i| i.nil? }
    cmc.empty? ? 0 : cmc.count
  end

  def get_notification_count
    get_unread_message_count +
    get_courses_requests_count +
    get_unread_course_member_conversations_count
  end

  def courses_organized_counter
    counter = 0
    courses = Course.unscoped.find(:all, :conditions => ["date < ? && user_id = ?", Time.now, self.id])
    courses.each do |f|
      if f.course_members.count > 0
        counter += 1
      end
    end
    counter
  end

  def courses_attended_counter
    counter = 0
    self.course_members.each do |f|
      if f.course.date < Time.now
        counter += 1
      end
    end
    counter
  end

  def push_message
    begin
      Pusher["#{self.id}"].trigger('counter', {:message => self.get_notification_count.to_s})
    rescue Pusher::Error => e
      #TODO handle Pusher Error
    end
  end

  private

  def set_city
    location = Location.find_by_country_and_zip_code(self.country, self.zip)
    self.city = location.nil? ? "n/a" : location.city
  end

end
