module ApplicationHelper

  def username(user)
    "#{user.first_name} #{user.last_name}"
  end

  def userpic(user, size)
    unless user.nil? || user.assets.empty?
      user.assets.first.image.nil? ? "http://placehold.it/260x180" : user.assets.first.image.url(size)
    else
      "http://placehold.it/260x180"
    end
  end

  def form_status(resource, key)
    resource.errors.any? ? resource.errors[key].any? ? 'error' : 'success' : ''
  end

  def form_status_msg(resource, key)
    resource.errors.any? ? resource.errors[key].any? ? resource.errors[key].first : 'ok' : ''
  end
end
