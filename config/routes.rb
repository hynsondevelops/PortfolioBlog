Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  resources :images
  resources :tags
  get 'markdown_url', to: "images#markdownURL"
  get 'portfolio', to: "posts#portfolio"
  get 'markdown', to: "posts#markdown_helper"
  root "posts#portfolio"
end
