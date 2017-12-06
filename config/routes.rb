Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  get 'portfolio', to: "posts#portfolio"
  get 'markdown', to: "posts#markdown_helper"
  root "posts#portfolio"
end
