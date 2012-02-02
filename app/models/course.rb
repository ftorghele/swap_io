class Course < ActiveRecord::Base

  def self.get_courses
    self.find(:all)
  end

end
