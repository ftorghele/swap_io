class Course < ActiveRecord::Base

  default_scope :order => "created_at DESC"

  belongs_to :user
  belongs_to :category
  has_many :course_members, :dependent => :destroy

  validates_presence_of :title, :description, :category_id, :user_id

  def provide_course_mailer course_request_id
    course_request = CourseRequest.find_by_id(course_request_id)
    course_request.users.each do |user|
      user_link = "http://wissenteilen.com/#{I18n.t('routes.users.as')}/#{user.id}"
      course_request_link = "http://wissenteilen.com/#{I18n.t('routes.courses.as')}/#{self.id}"
      SystemMailer.provide_course(user, user_link, course_request_link).deliver
    end
  end

  def self.delete_course user, id
    course = self.find(id)
    return unless user.id == course.user_id
    course.get_course_members.each do |member|
      SystemMailer.private_message(member.user, I18n.t('course.destroy.subject'),
                  I18n.t('course.destroy.body', :name => "#{member.user.first_name} #{member.user.last_name}") ).deliver
    end
    course.destroy
  end

  def self.course_member_request user, id
    course = self.find_by_id(id)
    user_link = "http://wissenteilen.com/#{I18n.t('routes.users.as')}/#{user.id}"
    course_link = "http://wissenteilen.com/#{I18n.t('routes.courses.as')}/#{course.id}"
    SystemMailer.request_course(course.user, user_link, course_link).deliver
  end

  def get_course_members
    self.course_members.all
  end

  def self.load_user_cookie user
    value = nil
    Category.all.each do |category|
      value ||= {:all => "0"}
      new_val = {category.title.to_sym => (user.category_abonnements.find_by_category_id(category)) ? "0" : "1" }.to_hash
      value = value.merge( new_val )
    end
    value.to_json
  end

  def self.set_new_cookie
    value = {:all => "0"}
    Category.all.each do |category|
      #TODO????????????
      new_val = {category.title.to_sym => "1"}.to_hash
      value = value.merge( new_val )
    end
    value.to_json
  end

  def self.set_courses json_str
    category_arr = []
    json_str.map do |key, value|
      category_arr << key if value==1
    end
    category_arr = Category.find_all_by_title(category_arr)
    (category_arr.length==0) ? Course.all : Course.find_all_by_category_id(category_arr)
  end

  def self.set_user_courses user
    return Course.all if user.category_abonnements.length < 1
    categories = []
    user.category_abonnements.each do |f| categories << f.category_id end
    Course.find_all_by_category_id(categories)
  end

end
