class Location < ActiveRecord::Base
  attr_accessible       :city, :zip_code, :country, :lat, :lon

  validates_presence_of :city, :zip_code, :country, :lat, :lon
  validates_uniqueness_of :country, :scope => :zip_code
end
