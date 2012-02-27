class Course < ActiveRecord::Base

  belongs_to :user, :foreign_key => 'user_id'
  has_many :attend_courses, :through => :courses
  belongs_to :category

  validates_presence_of :title, :description , :category_id

  def self.create_course params, user_id
    new_course = self.new params
    new_course.user_id = user_id
    new_course.save!
    new_course
  end
end
