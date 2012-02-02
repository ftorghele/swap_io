class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :gender

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :gender


  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password
      user = User.new(:email => data.email, :password => Devise.friendly_token[0,20])

      user.first_name = data["first_name"]
      user.last_name = data["last_name"]
      user.gender = data["gender"]

      #confirme the account but mark it as incomplete
      user.confirmed_at = Time.now
      user.complete = false
      user.save!

      user
    end
  end

end
