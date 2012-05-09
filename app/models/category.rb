class Category < ActiveRecord::Base
  has_many :courses

  attr_accessible :title
  validates_presence_of :title
end
