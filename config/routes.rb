Rails.application.routes.draw do
  root 'tickets#index'
  resources :tickets
  resources :pages, only: :show
end
