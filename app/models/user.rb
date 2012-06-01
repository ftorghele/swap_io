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
                  :description, :skills, :job, :motivation, :birthday,
                  :country, :city, :fb_user, :image, :crop_x, :crop_y, :crop_w, :crop_h

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :zip
  validates_presence_of :country
  validates_presence_of :city
  validates :zip, :numericality => { :only_integer => true }

  has_many :courses, :dependent => :destroy
  has_many :course_members, :through => :courses
  has_many :category_abonnements
  has_many :user_ratings, :dependent => :delete_all

  has_and_belongs_to_many :course_requests, :uniq => true

  has_attached_file :image,
                    :styles => { :thumb => "46x46#", :xsmall => "32x32#", :small => "60x60#", :medium => "300x300#", :big => "800x800>" },
                    :processors => [:cropper]

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
    self.courses
  end

  def get_course_requests
    self.course_requests
  end

  def get_accepted_course_memberships
    CourseMember.find_all_by_user_id_and_accepted(self.id, 1)
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
    email
  end

  private

  def set_city
    location = Location.find_by_country_and_zip_code(self.country, self.zip)
    self.city = location.nil? ? "n/a" : location.city
  end

end
