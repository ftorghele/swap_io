class Course < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :course_members, :through => :courses

  validates_presence_of :title, :description, :category_id, :user_id
end
