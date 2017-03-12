Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'businesses#index'
  
  resources :businesses, only: [:show, :new, :create]
  
  get 'sign_up', to: 'users#new'
  resources :users, only: [:create, :show]
  
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
