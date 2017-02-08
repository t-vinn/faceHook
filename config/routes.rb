# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'users/users#index'
  namespace :users do
    resources :follow_relationships, only: [:create, :destroy], module: :users
    resources :feeds, module: :users
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
