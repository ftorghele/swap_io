Swap::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

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
        post 'disjoin'
      end
    end

    resources :newsletter_subscribers do
      collection do
        get 'unsubscribe'
      end
    end

    resources :newsletters
    resources :courses
    resources :course_members
    resources :categories

    resource :mails

    get 'landingpage',  :to => 'pages#landingpage'
    get 'welcome',  :to => 'pages#welcome'
    get 'overview', :to => 'pages#overview'

    get 'help',     :to => 'pages#help'
    get 'tips',     :to => 'pages#tips'
    get 'rules',    :to => 'pages#help'
    get 'news',     :to => 'pages#news'
    get 'team',     :to => 'pages#team'
    get 'contact',  :to => 'pages#contact'
    get 'coverage', :to => 'pages#coverage'

    get 'about',    :to => 'pages#about'
    get 'imprint',  :to => 'pages#imprint'
    get 'terms',    :to => 'pages#terms'
    post 'contact_us',  :to => 'pages#contact_us'
  end

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end

  root :to => Rails.env.production? ? 'pages#landingpage' : 'courses#index'
end
