Rails.application.routes.draw do
 
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tweets#index'

  resources :users, only: [:index, :show]
  # resources :friendships
  resources :tweets do
    resources :replies, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
end
