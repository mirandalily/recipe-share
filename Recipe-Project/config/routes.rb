Rails.application.routes.draw do
  resources :categories
  devise_for :users
  root 'recipes#index'
  resources :recipes
end
