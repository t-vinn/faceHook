# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'users/users#index'
  namespace :users do
    resources :follow_relationships, only: [:create, :destroy], module: :users
    resources :feeds, module: :users do
      resources :replies, only: [:new, :create]
      resources :feeds_favorites, only: [:create, :destroy]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
