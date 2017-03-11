Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'businesses#index'
  
  resources :businesses, only: [:show, :new, :create]
  
  get 'sign_up', to: 'users#new'
  resources :users, only: [:create]
end
