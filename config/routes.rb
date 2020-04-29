Rails.application.routes.draw do
  get 'heat-map-data', to: "api_tutorials#heat_map_data"

  # Memipedia mobile
  namespace :memipedia do
    post 'memipedia_user_token' => 'memipedia_user_token#create'
    resources :memipedia_users
    resources :memipedia_posts
    resources :memipedia_queries, only: [:index]
    get :logged_in, to: 'memipedia_users#logged_in'
    resources :app_memipedia_users
    resources :app_memipedia_posts
  end

  # Portfolio
  namespace :portfolio do
    resources :portfolio_items, only: [:index, :show, :update, :create, :destroy]
    delete 'delete-portfolio-image/:id', to: 'portfolio_item_images#destroy'
    resources :portfolio_app_users
    resources :portfolio_blogs
    delete 'delete-portfolio-blog-image/:id', to: 'portfolio_blog_images#destroy'
  end

  # Portfolio Hook
  namespace :portfolio_hook do
    resources :portfolio_items, only: [:index, :show, :update, :create, :destroy]
    delete 'delete-portfolio-image/:id', to: 'portfolio_item_images#destroy'
    resources :portfolio_app_users
    resources :portfolio_blogs
    delete 'delete-portfolio-blog-image/:id', to: 'portfolio_blog_images#destroy'

    ## JWT Auth
    post 'user_token' => 'user_token#create'
    resources :users
  end

  # Ecom
  namespace :shop do
    resources :products
    resources :shop_user_sessions, only: [:create]
    resources :shop_user_registrations, only: [:create]
    delete :logout, to: 'shop_user_sessions#logout'
    get :logged_in, to: 'shop_user_sessions#logged_in'
  end

  # Devworkflow
  namespace :devworkflow do
    resources :check_list_items
    resources :project_line_items, only: [:show, :update]
    resources :devworkflow_projects, only: [:index, :create, :destroy, :update]
    resources :devworkflow_users, only: [:index, :create, :destroy, :update]
    resources :archived_projects, only: [:index, :update]
    resources :unarchive_projects, only: [:update]
    resources :registrations, only: [:create]
    resources :sessions, only: [:create]
    delete :logout, to: 'sessions#logout'
    get :logged_in, to: 'sessions#logged_in'
  end

  # Application

  ## Session Auth
  get 'registration-validations', to: 'clients#registration_validations'
  resources :sessions, only: [:create]
  delete :logout, to: 'sessions#logout'
  get :logged_in, to: 'sessions#logged_in'

  ## Data
  resources :projects, only: [:index, :show]
  resources :project_tables
  resources :client_domains, only: [:index, :create, :destroy]
  resources :app_templates
  resources :clients
  get 'get-client-applications', to: 'clients#get_client_applications'
  root to: 'home#index'
end
