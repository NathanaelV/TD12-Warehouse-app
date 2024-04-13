Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, only: %i[show new create edit update destroy]
  resources :suppliers, except: %i[edit update destroy]
end
