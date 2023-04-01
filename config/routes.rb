Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#home'
  get '/about', to: 'pages#about'
  resources :articles #, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories

  post 'follow/:user_id', to: 'users#follow'
  post 'unfollow/:user_id', to: 'users#unfollow'

  post 'article/:id/upvote', as: "upvote", to: 'articles#upvote'

  get 'search', to: 'pages#search'

  resources :messages, only: [:new, :create, :index]

  resources :messages, path: 'community', only: [:new, :create, :index]

end
