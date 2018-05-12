Plumber::Engine.routes.draw do
  resources :campaigns, only: :show
  resources :messages, only: :show
end
