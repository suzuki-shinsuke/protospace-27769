Rails.application.routes.draw do
  get 'comments/create'
  devise_for :users
  root to: 'prototypes#index'
  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
