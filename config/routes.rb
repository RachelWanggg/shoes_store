Rails.application.routes.draw do
  root "products#index"

  devise_for :users, sign_out_via: [:delete, :get]

  # Public products
  resources :products, only: [:index, :show]

  # Admin namespace
  namespace :admin do
    resources :products
  end

  # Cart and CartItems
  resource :cart, only: [:show]
  post   'add_to_cart/:product_id', to: 'cart_items#add',    as: 'add_to_cart'
  delete 'remove_from_cart/:id',  to: 'cart_items#remove', as: 'remove_from_cart'

  # Orders
  resources :orders, only: [:index, :show, :create]
end

