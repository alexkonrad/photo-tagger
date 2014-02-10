PhotoTagger::Application.routes.draw do
  resources :users, only: [:new, :create, :destroy, :index]
  resource :session, only: [:new, :create, :destroy]

  root to: "users#index"
end
