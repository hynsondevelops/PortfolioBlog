Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, param: :title
  resources :images
  resources :tags, param: :name
  resources :projects
  resources :contacts
  get 'markdown_url', to: "images#markdownURL"
  get 'portfolio', to: "projects#portfolio"
  get 'markdown', to: "posts#markdown_helper"
  root "posts#portfolio"
  get 'users/posts', to: "users#posts"
end
