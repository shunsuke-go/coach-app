Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  get '/guest_login', to: 'users#guest_login'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/help', to: 'static_pages#help'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
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
      get '/guest_login', to: 'users#guest_login'
      post '/login', to: 'sessions#create'
      get '/logged_in', to: 'sessions#react_logged_in?'
      delete '/logout', to: 'sessions#logout'
      get '/articles_all', to: 'articles#all'
      get '/users_all', to: 'users#all'
      get '/articles/users/:user_id', to: 'articles#logged_in_index'
      resources :rooms, only: [:show, :create]
      resources :users, only: [:show, :index, :create] do
        resources :likes, only: [:index]
        resources :reviews, only: [:index], controller: 'reviews'
        get '/relationships/followers_count', to: 'relationships#followers_count'
        get 'relationships/:followed_id/', to: 'relationships#following?'
        post 'relationships/:followed_id/', to: 'relationships#create'
        delete 'relationships/:followed_id/', to: 'relationships#destroy'
      end

      resources :articles do
        resources :comments, only: [:index, :create], controller: 'comments'
        resources :users, only: [:create, :index] do
          get '/likes/destroy_target', to: 'likes#destroy_target'
          resources :likes, only: [:create]
          delete '/likes', to: 'likes#destroy'
        end
        get '/likes/count', to: 'likes#count'
      end

      get '/users/?page=:page', to: 'users#index'
      get '/articles/?page=:page', to: 'articles#index'
      get '/users/:id/?page=:page', to: 'users#show'
    end
  end
end
