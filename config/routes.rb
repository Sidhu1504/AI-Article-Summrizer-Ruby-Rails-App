Rails.application.routes.draw do
  get 'articles/create'
  get 'articles/show'
  root "pages#home"

  resources :articles, only: [:create, :show]

  get "up" => "rails/health#show", as: :rails_health_check
end
