Rails.application.routes.draw do
  resources :categories do
    resources :recipes, only: [:show, :index]
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'recipes#index'
  resources :recipes

end
