module ApplicationHelper

  def username(user)
    "#{user.first_name} #{user.last_name}"
  end

  def userpic(user, size = :medium)
    unless user.nil? || user.user_images.empty?
      user.user_images.first.image.url(size)
    else
      if size == :thumb
        "http://placehold.it/45x45"
      elsif size == :medium
        "http://placehold.it/60x60"
      else
        "http://placehold.it/300x200"
      end
    end
  end

  def safe_output value
    value.nil? ? "n/a" : value
  end
end
