Rails.application.routes.draw do
  get "home/about" => "home#about"
  root to:  'home#top'
  devise_for :users
  resources :users do
  	member do
  		get :following, :followers
  	end
  end
  resources :books do
  	resource :favorites, only:[:create, :destroy]
  	resources :book_comments, only:[:create, :destroy]
  end
  resources :relationships, only:[:create, :destroy]
  get "/search" => "search#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
