Rails.application.routes.draw do
  resources :products
  resources :orders, only: [:index, :show, :create]
  root "home#index"
  get "dashboard", to: "home#dashboard", as: :dashboard

  get "cart", to: "cart#show", as: :cart
  post "cart/add/:variant_id", to: "cart#add", as: :add_to_cart
  delete "cart/remove/:variant_id", to: "cart#remove", as: :remove_from_cart
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
