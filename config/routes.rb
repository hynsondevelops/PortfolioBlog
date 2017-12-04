Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  get 'portfolio', to: "posts#portfolio"
  post 'markdown', to: "posts#render_markdown"
  root "posts#portfolio"
end
