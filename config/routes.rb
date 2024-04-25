Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: %i[show new create edit update destroy]
  resources :suppliers, except: %i[destroy]
  resources :product_models, only: %i[index new create show]
  resources :orders, only: %i[index show new create edit update] do
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
  end
end
