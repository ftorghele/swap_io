module CategorySearch

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def load_user_cookie user
      value = nil
      Category.all.each do |category|
        value ||= { }
        new_val = {category.title.to_sym => (user.category_abonnements.find_by_category_id(category)) ? "0" : "1" }.to_hash
        value = value.merge( new_val )
      end
      value.to_json
    end

    def set_new_cookie
      value = { }
      Category.all.each do |category|
        new_val = {category.title.to_sym => 1}.to_hash
        value = value.merge( new_val )
      end
      value.to_json
    end

    def set_courses json_str
      category_arr = []
      json_str.map do |key, value|
        category_arr << key if value.to_i == 0
      end
      categories = Category.all(:select => "id", :conditions => {"title" => category_arr}).collect(&:id)
      if self == Course
        categories.empty? ? self.all : self.all(:include => :categories, :conditions => { "categories_courses.category_id" => categories})
      else
        categories.empty? ? self.all : self.all(:include => :categories, :conditions => { "categories_course_requests.category_id" => categories})
      end
    end

    def set_user_courses user
      return self.all if user.category_abonnements.length < 1
      categories = []
      user.category_abonnements.each do |f| categories << f.category_id end
      if self == Course
        categories.empty? ? self.all : self.all(:include => :categories, :conditions => { "categories_courses.category_id" => categories})
      else
        categories.empty? ? self.all : self.all(:include => :categories, :conditions => { "categories_course_requests.category_id" => categories})
      end
    end

    def find_category_abonnements(user, is_course)
      categories = []
      CategoryAbonnement.find_all_by_user_id(user).map { |f| categories << f.category }.flatten
      if is_course
        (categories.present?) ? self.all(:include => :categories, :conditions => { "categories_courses.category_id" => categories}) : self.all
      else
        (categories.present?) ? self.all(:include => :categories, :conditions => { "categories_course_requests.category_id" => categories}) : self.all
      end
    end

  end
end
