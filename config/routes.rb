Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: %i[show new create edit update destroy]
  resources :suppliers, except: %i[destroy]
  resources :product_models, only: %i[index new create show]
  resources :orders, only: %i[show new create] do
    get 'search', on: :collection
  end
end
