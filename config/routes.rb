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
    resources :course_requests
    resources :courses

    get 'home',     :to => 'pages#home'
    get 'terms',    :to => 'pages#home'
    get 'help',     :to => 'pages#home'
    get 'coverage', :to => 'pages#home'
    get 'contact',  :to => 'pages#home'
    get 'about',    :to => 'pages#home'
    get 'imprint',  :to => 'pages#home'
  end

  root :to => 'pages#overview'
end
