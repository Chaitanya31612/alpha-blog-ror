Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # ============ PAGES ============#
  root 'pages#home'
  get 'search', to: 'pages#search'

  # ============ USERS ============#
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  post 'follow/:user_id', to: 'users#follow'
  post 'unfollow/:user_id', to: 'users#unfollow'

  # ============ SESSION ============#
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # ============ ARTICLES ============#
  resources :articles
  post 'article/:id/upvote', as: "upvote", to: 'articles#upvote'

  # ============ CATEGORIES ============#
  resources :categories

  # ============ MESSAGES ============#
  resources :messages, only: [:new, :create, :index]
  resources :messages, path: 'community', only: [:new, :create, :index]

end
