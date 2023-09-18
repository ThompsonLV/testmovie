Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "movies#index"

  resources :movies, only: %i[new create show index destroy] do
    resources :casts, only: %i[new show]
    resources :categories, only: %i[new show]
  end
end
