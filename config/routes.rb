Rails.application.routes.draw do
  root "queries#new"
  resources :queries, only: [:index, :create]
  resource :schema, only: :show, controller: :schema

  get "up" => "rails/health#show", as: :rails_health_check
end
