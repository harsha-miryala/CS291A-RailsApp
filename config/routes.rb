Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"

  resources :comments

  resources :users do
    resources :comments
  end

  resources :posts do
    resources :comments
  end

  resources :users do
    resources :posts
  end

end
