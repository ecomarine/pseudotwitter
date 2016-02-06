Rails.application.routes.draw do
  root  'pages#home'
  
  resources :users do
  member do
      get :following, :followers
    end
  end
    
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  
  
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  

  match '/about', to: 'pages#about', via: :get

  match  '/contacts', to: 'pages#contacts', via: :get

  match '/help', to: 'pages#help', via: :get
  
  match '/signup', to: 'users#new', via: :get
  

end
