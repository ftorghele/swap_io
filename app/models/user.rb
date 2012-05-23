class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me,
                  :first_name, :last_name, :zip, :confirmed_at, :user_images_attributes,
                  :description, :user_skills_attributes, :job, :motivation

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :zip
  validates :zip, :numericality => { :only_integer => true }

  has_many :courses, :dependent => :destroy
  has_many :course_members, :through => :courses
  has_many :category_abonnements

  has_and_belongs_to_many :course_requests, :uniq => true

  has_many :user_skills, :dependent => :delete_all
  accepts_nested_attributes_for :user_skills, :reject_if => proc {|attributes| attributes[:title].blank?}, :allow_destroy => true

  has_many :user_images, :dependent => :delete_all
  accepts_nested_attributes_for :user_images, :allow_destroy => true

  has_and_belongs_to_many :course_requests

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else
      user = User.new(:email => data.email,
                      :first_name => data.first_name,
                      :last_name => data.last_name)
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

  def get_courses
    self.courses
  end

  def get_course_requests
    self.course_requests
  end

  def get_accepted_course_memberships
    CourseMember.find_all_by_user_id_and_accepted(self.id, 1)
  end

  def find_category_abonnements
    categories = CategoryAbonnement.find_all_by_user_id(self).map { |f| f.category.courses }.flatten
    Course.all #find_all_by_category_id(categories)
  end

  def toggle_category_abonnements category
    if category_abonnement = self.category_abonnements.find_by_category_id(category.id)
      category_abonnement.destroy
    else
      self.category_abonnements.create(:category => category)
    end
  end

end
