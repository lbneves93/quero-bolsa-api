Rails.application.routes.draw do
  root to: 'application#home'
  resources :courses, only: [:index]
  resources :offers, only: [:index]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
