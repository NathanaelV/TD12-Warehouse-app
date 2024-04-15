Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: %i[show new create edit update destroy]
  resources :suppliers, except: %i[destroy]
  resources :product_models, only: %i[index new create show]
end
