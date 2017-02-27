# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'users/users#index'
  namespace :users do
    resources :follow_relationships, only: [:create, :destroy], module: :users
    resources :groups, except: [:new, :destroy], module: :users do
      resources :groups_users, only: [:create, :destroy]
      resources :group_posts, only: [:create]
    end
    resources :feeds, except: [:new], module: :users do
      resources :replies, only: [:new, :create] do
        resources :reply_favorites, only: [:create, :destroy]
      end
      resources :feed_favorites, only: [:create, :destroy]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
