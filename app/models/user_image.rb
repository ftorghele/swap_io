class UserImage < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :big => "300x200>", :medium => "60x60>", :thumb => "45x45>" }
end
