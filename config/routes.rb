Rails.application.routes.draw do
  devise_for :landlords
  devise_for :tenants
  root 'pages#home'
  get 'about', to: 'pages#about'
end
