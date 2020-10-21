# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tweets#index'

  # resources :users, only: [:index, :show]
  # resources :friendships
  resources :tweets do
    resources :replies, only: %i[create destroy]
    resources :likes, only: %i[create destroy]
  end
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i[create destroy]
end
