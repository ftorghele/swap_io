class Course < ActiveRecord::Base

  belongs_to :user, :foreign_key => 'user_id'
  belongs_to :category
  has_many :course_members, :through => :courses

  validates_presence_of :title, :description , :category_id

  def self.create_course params, user_id
    new_course = self.new params
    new_course.user_id = user_id
    new_course.save!
    new_course
  end
end
