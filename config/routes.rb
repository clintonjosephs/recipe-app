Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "recipes#index"
  resources :recipes, only: [:index, :show, :new, :destroy, :create]
  resources :foods, only: [:index, :show, :new, :destroy, :create]
  resources :inventories, only: [:index, :show, :new, :destroy, :create] do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end
  get "/public_recipes", to: "recipes#public_recipes"
  get "/general_shopping_list", to: "foods#general_shopping_list"
end
