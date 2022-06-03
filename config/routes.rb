Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :show, :new, :create, :edit, :update]
  resources :orders, only: %i[new create show index edit update] do
    resources :order_items, only: %i[ new create ]
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
  end
end
