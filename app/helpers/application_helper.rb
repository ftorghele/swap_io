module ApplicationHelper

  def username(user)
    "#{user.first_name} #{user.last_name}"
  end

  def form_status(resource, key)
    resource.errors.any? ? resource.errors[key].any? ? 'error' : 'success' : ''
  end

  def form_status_msg(resource, key)
    resource.errors.any? ? resource.errors[key].any? ? resource.errors[key].first : 'ok' : ''
  end
end
