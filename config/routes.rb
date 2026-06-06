Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]

  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  get "favorites", to: "tweets#favorites"
  get "about", to: "homes#about"
  root 'tweets#index'

  resources :tags, only: [:create]
end