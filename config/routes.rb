Rails.application.routes.draw do
  get "about", to: "home#about", as: :about
  resources :categories
  resources :posts
  root "home#index"
end
