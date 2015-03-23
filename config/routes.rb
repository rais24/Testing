require 'sidekiq/web'
require 'routing/admin_constraint'

Fitly::Application.routes.draw do
  resources :zipcodes

  root to: 'signup#index'

  get 'pages/*id' => 'pages#show'

  get 'crohns_disease' => 'signup#crohns_disease_landing'
  get 'diabetes' => 'signup#diabetes_landing'
  get 'diabetes_type2' => 'signup#diabetes_type2_landing'
  get 'gastric_bypass' => 'signup#gastric_bypass_landing'
  get 'gluten_free' => 'signup#gluten_free_landing'
  get 'heart_disease' => 'signup#heart_disease_landing'
  get 'hypertension' => 'signup#hypertension_landing'
  get 'kidney_disease' => 'signup#kidney_disease_landing'
  get 'pre_diabetes' => 'signup#pre_diabetes_landing'
  get 'renal_disease' => 'signup#renal_disease_landing'
  get 'weightloss' => 'signup#weightloss_landing'

  get 'available_time_slots' => 'delivery_zones#available_time_slots', as: :available_time_slots

  resource :signup, only: [:create, :new, :update], controller: :signup do
    get 'zipcode_check'
    get 'visitor'
    get 'complete'
    get 'signup_newsletter'
    
    post 'crohns_disease_inquiry'
    post 'diabetes_inquiry'
    post 'diabetes_type2_inquiry'
    post 'gastric_bypass_inquiry'
    post 'gluten_free_inquiry'
    post 'heart_disease_inquiry'
    post 'hypertension_inquiry'
    post 'kidney_disease_inquiry'
    post 'pre_diabetes_inquiry'
    post 'renal_disease_inquiry'
    post 'weightloss_inquiry'

    collection do
      post 'queue_signup_inquiry'
    end
  end

  resource :sessions
  resource :billing
  resource :registration
  resources :checkouts
  resources :subscription
  resource :order_confirmations, :only => [:create]
  
  resources :order_substitutions
  get 'substitutions' => 'order_substitutions#index'

  resources :shopping_cart_items, :only => [:create, :update, :destroy]
  resources :purchases
  resource :shopping_cart, :only => [:show]
  resource :account, :only => [:index, :edit, :update, :show] do
    get 'show_patients'
  end
  resource :promos, :only => [:create]

  resources :password_resets

  # index is admin only
  resources :users do
    resources :orders, :only => [:index, :show]
    resource :meal_plan
    member do
      get 'resend_activation'
      # resend the unlock email
      get 'welcome'
      # unlock a user
      get 'unlock'
      # turn a guest user into a full one
      put 'complete'
    end
  end

  resources :recipes do
    member do
      delete 'clear_portions' => 'recipes#clear_portions', as: :clear_portions
    end
    resources :portions, controller: 'recipe_portions', as: :recipe_portions
  end

  resources :orders do
    resources :order_servings, path: :servings
    resources :order_portions, path: :portions do
      member do
        post 'reset' => 'order_portions#reset', as: :reset
      end
    end

    member do
      get 'shop' => 'orders#shop', as: :shop
      get 'export' => 'orders#export', as: :export
      get 'check' => 'orders#check', as: :check
      get 'preparation' => 'orders#preparation', as: :preparation
      get 'pdf'
    end
  end

  resources :sitemaps, :only => :index
  get "sitemap" => "sitemaps#index"

  resources :landing_pages, :only => [:index, :show, :create]
  resources :mailing_list_users, :only => [:create]

  get 'dashboard' => 'dashboard#show', as: :dashboard

  # facebook login
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'logout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  # Admin only
  resources :ingredients, :products, :stores

  resources :delivery_sites, path: :sites

  namespace :admin do
    constraints Routing::AdminConstraint do
      mount Sidekiq::Web => 'sidekiq'
    end
    root to: "dashboard#index"
    resources :dashboard, :promos, :delivery_zones, :zipcodes
    resources :recipes, :only => [:index] do
      collection do
        post :publish
      end
    end

    resources :orders do
      get :resend_bpo, :resend_missing, :resend_confirmation, :resend_recipes
    end

    get 'order_details' => 'reports#order_details'
    get 'monthly_report' => 'reports#monthly_report'
  end

  resources :messages
  resources :conversations

  if Rails.env.development?
    mount MailerPreview => 'mail_view'
  end
  
  namespace :api  do
    resources :recipes, :only => [:index]   
  end
  #resources :conversations, only: [:index, :show, :new, :create] do
  #  member do
  #    post :reply
  #    post :trash
  #    post :untrash
  #  end
  #end
end
