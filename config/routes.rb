Rails.application.routes.draw do
  root to: 'application#home'
  resources :courses, only: [:index]
  resources :offers, only: [:index]
end
