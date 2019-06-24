Rails.application.routes.draw do


  get 'microposts/new'
  get 'microposts/index'
  root 'static_pages#home'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :sessions
  resources :microposts, only: [:new, :create, :index]
  
  
end
