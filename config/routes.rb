Plumber::Engine.routes.draw do
  resources :campaigns, only: [:index, :show]
  resources :messages, only: :show
end
