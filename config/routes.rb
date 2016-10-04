Rails.application.routes.draw do

  resources :comments, only:[:index, :create, :new]
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'recipes#index'

  resources :ingredients

  resources :recipes do
    resources :ingredients
  end

  resources :categories do
    resources :recipes
  end

end
