Swap::Application.routes.draw do

  devise_for :users, :controllers => {
      :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  localized(I18n.available_locales) do
    resources :users do

    end
    resources :course_requests
    resources :courses
  end

  match 'fb_finish', :to => 'users#fb_finish', :as => 'fb_finish'

  root :to => 'courses#index'
end
