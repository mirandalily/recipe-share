Rails.application.routes.draw do
  resources :categories do
    resources :recipes
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'recipes#index'
  resources :recipes

  resources :users do
    resources :recipes do
      resources :comments, only: [:create,:destroy]
    end
  end
end
