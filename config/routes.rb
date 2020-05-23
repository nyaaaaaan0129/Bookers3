Rails.application.routes.draw do
  get "home/about" => "home#about"
  root to:  'home#top'
  devise_for :users
  resources :users
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
