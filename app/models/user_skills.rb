class UserSkills < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :title, :user_id
end
