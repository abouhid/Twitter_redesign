Rails.application.routes.draw do
  resources :likes
  resources :replies
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :tweets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tweets#index'

  resources :users, only: [:index, :show]

  # resources :friendships
  # resources :posts, only: [:index, :create] do
  #   resources :comments, only: [:create]
  #   resources :likes, only: [:create, :destroy]
  # end
end
