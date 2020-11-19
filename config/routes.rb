Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'

  get '/signup', to: 'users#new'
  get '/help', to: 'static_pages#help'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following,:followers
    end
  end
  
  resources :relationships, only:[:create,:destroy]
  resources :articles, only:[:create,:destroy,:show] do
    resources :comments,only:[:create,:destroy]
  end

  get '/articles', to: 'static_pages#home'
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
