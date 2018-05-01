Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :post_images
  resources :project_images
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:edit, :update]
  resources :posts, param: :title
  resources :images, only: [:create]
  resources :tags, param: :name, only: [:show, :create, :index]
  resources :projects, only: [:new, :create, :show, :index]
  resources :contacts, only: [:create, :show, :index]
  get 'markdown_url', to: "images#markdownURL"
  get 'portfolio', to: "projects#portfolio"
  get 'markdown', to: "posts#markdown_helper"
  root "posts#index"
  get 'users/posts', to: "users#posts"
end
