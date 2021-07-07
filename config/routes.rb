Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'

  get "login", to: 'sessions#new', as: 'login'
  get "logout", to: "sessions#destroy", as: 'logout'
  resources :sessions, only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]


  namespace :backend do
    resources :users
    resources :favorite_blogposts
    get 'dashboard', to: 'dashboard#dashboard'
  end

  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'sessions#authenticate', as: 'authenticate'
      get "logout", to: "sessions#destroy", as: 'logout'
      resource :sessions, only: [:show]

      resources :users

      get 'favorits', to: 'favorite_blogposts#favorits'
      post 'favorise', to: 'favorite_blogposts#favorise'
      post 'defavorise', to: 'favorite_blogposts#defavorise'
    end
  end

  resources :users do
    get :activate, on: :member
    post :reset_password, on: :member
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
