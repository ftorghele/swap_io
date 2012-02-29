class CourseRequest < ActiveRecord::Base

  has_and_belongs_to_many :users, :uniq => true

  validates_presence_of :title, :description
end
