Rails.application.routes.draw do
  resources :invitations
  devise_for :users
  resources :events
  resources :users
  resources :event_joinings
  resources :invitations do
    member do
      get 'accept'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'events#index'
end
