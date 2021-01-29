Rails.application.routes.draw do
  resources :courses, only: [:index]
  resources :offers, only: [:index]
end
