Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  get '/guest_login', to: 'users#guest_login'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/help', to: 'static_pages#help'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    resources :reviews, only: [:create, :destroy, :index]
    get '/reviews/ave_point_cal', to: 'reviews#ave_point_cal'
    resources :likes, only: [:index]
    resources :profiles, only: [:create, :update, :new, :edit]
    member do
      get :reviewing, :reviewers
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :articles, only: [:create, :destroy, :show, :index, :new, :edit, :update] do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    collection do
      get :tags
    end
  end
  get '/articles', to: 'static_pages#home'
  resources :searches, only: [:index, :new]

  resources :rooms, only: [:show, :create, :index]
  resources :messages, only: [:create, :destroy]
  get 'messages/box/:id', to: 'messages#box'
  resources :notifications, only: [:index] do
    collection do
      delete 'destroy_all'
    end
  end

  resources :maps, only: [:index, :new]

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :users do
        resources :reviews, only: [:index], controller: 'reviews'
        get '/relationships/followers_count', to: 'relationships#followers_count'
      end

      resources :articles do
        resources :comments, only: [:index], controller: 'comments'
        get '/likes/count', to: 'likes#count'
      end

      get '/articles', to: 'articles#index'
    end
  end
end
