class Category < ActiveRecord::Base
  has_many :courses
  has_and_belongs_to_many :course_requests
  has_many :category_abonnements

  attr_accessible :title
  validates_presence_of :title
end
