Rails.application.routes.draw do
  get 'mypage/index'
  devise_for :users
  root to: 'articles#index'
  get '/mypage', to: 'mypage#show'
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
