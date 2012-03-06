ActiveAdmin.register Newsletter do

  index do
    column :title
    column :body
    column :sent

    # do
    #   strong { link_to "Send Newsletter", update_newsletter_path()  }
    # end

    default_actions
  end
end
