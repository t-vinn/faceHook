Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  root 'users/users#index'
  namespace :users do
    resources :users do
      resources :follow_relationships
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
