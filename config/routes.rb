Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/home'
  get '/help', to: 'static_pages#help'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
