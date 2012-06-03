class UserKey < ActiveRecord::Base
  attr_accessible :key
  validates_presence_of :key
end
