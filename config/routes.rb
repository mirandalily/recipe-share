Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'recipes#index'

  resources :ingredients

  resources :recipes do
    resources :ingredients
    resources :comments
  end

  resources :categories do
    resources :recipes
  end

end
