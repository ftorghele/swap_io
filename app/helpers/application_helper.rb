module ApplicationHelper

  def username(user)
    "#{user.first_name} #{user.last_name}"
  end

  def userpic(user, size = :medium)
    unless user.nil? || user.image.nil?
      user.image.url(size)
    else
      if size == :thumb
        "http://placehold.it/46x46"
      elsif size == :medium
        "http://placehold.it/60x60"
      else
        "http://placehold.it/300x300"
      end
    end
  end

  def coursepic(course, size = :medium)
    unless course.nil? || course.image.nil?
      course.image.url(size)
    else
      if size == :thumb
        "http://placehold.it/46x46"
      elsif size == :xsmall
        "http://placehold.it/100x100"
      elsif size == :small
        "http://placehold.it/220x220"
      elsif size == :medium
        "http://placehold.it/300x300"
      else
        "http://placehold.it/800x800"

      end
    end
  end

  def safe_output value
    value.nil? ? "n/a" : value
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

   def get_notifications user
     counter = user.get_notification_count
     link_to counter.to_s , user_conversations_path, :id => 'nav-dashboard-indicator', :class => (counter==0) ? 'nav-dashboard-indicator' : 'nav-dashboard-indicator-new'
   end
end
