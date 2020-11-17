Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'

  get '/signup', to: 'users#new'
  get '/help', to: 'static_pages#help'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :articles, only:[:create,:destroy,]
  get '/articles', to: 'static_pages#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
