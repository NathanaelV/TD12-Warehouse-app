Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :warehouses, only: %i[show new create edit update destroy] do
    resources :stock_product_destinations, only: [:create]
  end

  resources :suppliers, except: %i[destroy]
  resources :product_models, only: %i[index new create show]

  resources :orders, only: %i[index show new create edit update] do
    resources :order_items, only: %i[new create]

    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :warehouses, only: %i[show index create]
    end
  end
end
