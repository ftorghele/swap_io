module ApplicationHelper

  def username(user)
    "#{user.first_name} #{user.last_name}"
  end

  def userpic(user, size)
    unless user.nil? || user.user_images.empty?
      user.user_images.first.image.nil? ? "http://placehold.it/260x180" : user.user_images.first.image.url(size)
    else
      "http://placehold.it/260x180"
    end
  end
end
