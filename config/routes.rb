Swap::Application.routes.draw do

  devise_for :users, :controllers => {
      :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  localized(I18n.available_locales) do
    resources :course_requests
    resources :courses
  end

  root :to => 'courses#index'
end
