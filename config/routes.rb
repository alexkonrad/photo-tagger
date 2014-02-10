PhotoTagger::Application.routes.draw do
  resources :users, only: [:new, :create, :destroy, :index]
  resource :session, only: [:new, :create, :destroy]

  namespace "api", defaults: { format: :json } do
    resources :photos, only: [:create]

    resources :users, only: [] do
      get 'photos', on: :member
    end

    resources :photos, only: [] do
      get :photo_taggings, on: :member
    end

    resources :photo_taggings, only: [:create]
  end

  root to: "users#index"
end
