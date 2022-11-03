Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  # get 'books/new'
  # get 'books/index'
  # get 'books/show'
  # get 'books/edit'
  devise_for :users
  root to: 'homes#top'
  # get 'homes/about'
  get 'home/about'  => "homes#about"
  # resources books, only: []
  resources :books, only: [:new, :create, :index, :show, :edit, :update]
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
