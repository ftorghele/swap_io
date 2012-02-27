class UserImage < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "260x180>", :thumb => "65x45>" }
end
