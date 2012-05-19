module ApplicationHelper

  def username(user)
    "#{user.first_name} #{user.last_name}"
  end

  def userpic(user, size = :medium)
    unless user.nil? || user.user_images.empty?
      user.user_images.first.image.url(size)
    else
      (size == :thumb)? "http://placehold.it/45x45" : "http://placehold.it/260x180"
    end
  end
end
