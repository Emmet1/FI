Rails.application.routes.draw do
  resources :listings
  devise_for :landlords
  devise_for :tenants
  root 'pages#home'
  get 'about', to: 'pages#about'
end
