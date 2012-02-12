class Course < ActiveRecord::Base

  belongs_to :user, :foreign_key => 'user_id'
  has_many :attend_courses, :through => :courses

  validates_presence_of :title, :description
end
