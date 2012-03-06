ActiveAdmin.register Newsletter do

  index do
    column :title
    column :body
    column :sent

    default_actions
  end
end
