Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :api do
    namespace :v1 do
      # API authentication routes
      get 'auth/:provider/callback', to: 'authentication#social_auth'
    end
  end

  resources :articles, only: [:index, :new, :create]

  root 'articles#index'
end
