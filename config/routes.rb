Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "publics#index"
  resources :recipes, only: [:index, :show, :new, :destroy, :create, :update] do
    resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
  end
  resources :foods, only: [:index, :show, :new, :destroy, :create]
  resources :inventories, only: [:index, :show, :new, :destroy, :create]
  resources :publics, only: [:index]
end
