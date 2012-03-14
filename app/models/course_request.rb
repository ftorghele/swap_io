class CourseRequest < ActiveRecord::Base

  default_scope :order => "created_at DESC"

  has_and_belongs_to_many :users, :uniq => true

  validates_presence_of :title, :description
end
