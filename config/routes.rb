Swap::Application.routes.draw do

  resources :attend_courses

  devise_for :users, :controllers => {
      :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  localized(I18n.available_locales) do
    resources :users do
      collection do
        post 'fb_create'
      end
    end
    resources :course_requests do
      collection do
        post 'join'
      end
    end

    resources :courses
  end

  root :to => 'courses#index'
end
