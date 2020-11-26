Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'

  get '/signup', to: 'users#new'
  get '/help', to: 'static_pages#help'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
  resources :likes,only:[:index]
  resources :profiles,only:[:create,:update,:new,:edit]
    member do
      get :following,:followers
    end
  end
  
  resources :relationships, only:[:create,:destroy]

  resources :articles, only:[:create,:destroy,:show,:index] do
    resources :comments,only:[:create,:destroy]
    resources :likes,only:[:create,:destroy]
  collection do
    get :tags
  end
  end
  get '/articles', to: 'static_pages#home'
  
  resources :rooms,only:[:show,:create,:index]
  resources :messages,only: :create
  resources :notifications,only: [:index] do
    collection do
      delete 'destroy_all'
    end
  end
  
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
