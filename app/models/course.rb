class Course < ActiveRecord::Base

  belongs_to :user, :foreign_key => 'user_id'

  validates_presence_of :title, :description
end
