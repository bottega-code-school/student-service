Rails.application.routes.draw do
  get 'heat-map-data', to: "api_tutorials#heat_map_data"

  # Portfolio
  namespace :portfolio do
    resources :portfolio_items, only: [:index, :show, :update, :create, :destroy]
    delete 'delete-portfolio-image/:id', to: 'portfolio_item_images#destroy'
    resources :portfolio_app_users
    resources :portfolio_blogs
    delete 'delete-portfolio-blog-image/:id', to: 'portfolio_blog_images#destroy'
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
  resources :projects, only: [:index, :show]
  resources :project_tables
  resources :client_domains, only: [:index, :create, :destroy]
  resources :app_templates
  resources :clients
  resources :sessions, only: [:create]
  delete :logout, to: 'sessions#logout'
  get :logged_in, to: 'sessions#logged_in'
  get 'get-client-applications', to: 'clients#get_client_applications'
  get 'registration-validations', to: 'clients#registration_validations'
  root to: 'home#index'
end
