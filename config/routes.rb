Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'

  get "login", to: 'sessions#new', as: 'login'
  get "logout", to: "sessions#destroy", as: 'logout'
  resources :sessions, only: [:new, :create]
  resources :password_resets, only:[:new, :create, :edit, :update]


  namespace :backend do
    resources :users
    resources :favorite_blogposts
    resources :topics
    resources :tickets
    resources :comments
    get 'dashboard', to: 'dashboard#dashboard'
    get 'chart', to: 'dashboard#chart'
  end

  namespace :api do
    namespace :v1 do
      resources :password_resets, only: [:create]
      patch "resets_pw", to: 'password_resets#reset_pw'
      post 'authenticate', to: 'sessions#authenticate', as: 'authenticate'
      get "logout", to: "sessions#destroy", as: 'logout'
      resource :sessions, only: [:show]

      resources :users

      get 'favorits', to: 'favorite_blogposts#favorits'
      post 'favorise', to: 'favorite_blogposts#favorise'
      post 'defavorise', to: 'favorite_blogposts#defavorise'

      get 'topics', to: 'topics#topics'
      post 'add_topic', to: 'topics#add_topic'
      post 'remove_topic', to: 'topics#remove_topic'

      resources :tickets
      resources :comments
    end
  end

  resources :users do
    get :activate, on: :member
    post :reset_password, on: :member
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
