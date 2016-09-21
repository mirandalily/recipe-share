Rails.application.routes.draw do

  resources :comments, only:[:index, :create, :new]
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'recipes#index'
  resources :recipes do
    resources :ingredients
  end
  resources :ingredients

end
