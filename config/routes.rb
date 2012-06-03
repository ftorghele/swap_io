Swap::Application.routes.draw do

  scope :beta, :as => :beta, :constraints => { :subdomain => "beta" } do

    ActiveAdmin.routes(self)
    devise_for :admin_users, ActiveAdmin::Devise.config

    devise_for :users, :controllers => {
        :omniauth_callbacks => 'users/omniauth_callbacks'
    }

    localized(I18n.available_locales) do

      resources :user_conversations, only: [:index, :show, :new, :create] do
        member do
          post :reply
          post :trash
          post :untrash
          post :new
        end
      end

      resources :users do
        resources :user_ratings
        collection do
          post 'fb_create'
          get 'settings'
        end
      end

      resources :courses do
        collection do
          post :new_with_request
        end
      end

      resources :course_requests do
        collection do
          post :join
          post :disjoin
        end
      end

      resources :newsletter_subscribers do
        collection do
          get 'unsubscribe'
        end
      end

      resources :category_abonnements do
        collection do
          get 'find_categories'
        end
      end

      resources :newsletters
      resources :course_members
      resources :categories

      resource :mails

      get 'landingpage',  :to => 'pages#landingpage'
      get 'welcome',  :to => 'pages#welcome'
      get 'my_courses', :to => 'users#my_courses'
      get 'my_course_requests', :to => 'users#my_course_requests'
      get 'my_conversations', :to => 'users#my_conversations'

      get 'help',     :to => 'pages#help'
      get 'tips',     :to => 'pages#tips'
      get 'rules',    :to => 'pages#rules'
      get 'news',     :to => 'pages#news'
      get 'team',     :to => 'pages#team'
      get 'contact',  :to => 'pages#contact'
      get 'coverage', :to => 'pages#coverage'

      get 'about',    :to => 'pages#about'
      get 'imprint',  :to => 'pages#imprint'
      post 'contact_us',  :to => 'pages#contact_us'
    end

    unless Rails.application.config.consider_all_requests_local
      match '*not_found', to: 'errors#error_404'
    end

    root :to => 'pages#welcome'
  end

  scope :www, :as => :www, :constraints => { :subdomain => ["", "www"] } do
    localized(I18n.available_locales) do

      resources :newsletter_subscribers do
        collection do
          get 'unsubscribe'
        end
      end

      get 'landingpage',  :to => 'pages#landingpage'
    end

    unless Rails.application.config.consider_all_requests_local
      match '*not_found', to: 'errors#error_404'
    end

    root :to => 'pages#landingpage'
  end
end
