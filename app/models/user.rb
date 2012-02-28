class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :zip, :confirmed_at, :user_images_attributes,
                  :description

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :zip
  validates :zip, :numericality => { :only_integer => true }

  has_many :courses
  has_many :course_member, :through => :courses
  has_many :user_sills
  has_and_belongs_to_many :course_requests

  has_many :user_images, :dependent => :destroy
  accepts_nested_attributes_for :user_images, :allow_destroy => true

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

end
