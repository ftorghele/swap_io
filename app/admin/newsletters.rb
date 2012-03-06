ActiveAdmin.register Newsletter do

  index do
    column :title
    column :body
    column :sent do |newsletter|
      if newsletter.sent
        newsletter.updated_at
      else
        link_to "Send Newsletter", newsletter_path(newsletter.id), :method => :put
      end
    end
    default_actions
  end
end
