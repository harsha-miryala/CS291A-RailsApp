Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #root 'users#index'
  root 'posts#index'

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
