Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users
  
  get "friends_list", to: "friendships#friends_list"

  get "pending_requests", to: "friendships#pending_requests"

  resources :friendships

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
