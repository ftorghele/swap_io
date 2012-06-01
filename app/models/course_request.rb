class CourseRequest < ActiveRecord::Base
  include CategorySearch

#  default_scope :order => "created_at DESC"

  has_and_belongs_to_many :users, :uniq => true
  has_and_belongs_to_many :categories

  validates_presence_of :title, :description

  attr_accessible :title, :description, :category_ids

  validates_presence_of :category_ids
  validates :category_ids, :inclusion => [100], :if => Proc.new { |x|  x.category_ids.count > 3 }

end
