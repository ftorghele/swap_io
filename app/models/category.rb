class Category < ActiveRecord::Base
  has_many :courses
  has_many :category_abonnements

  attr_accessible :title
  validates_presence_of :title
end
