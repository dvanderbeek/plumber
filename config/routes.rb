Plumber::Engine.routes.draw do
  resources :campaigns do
    resources :messages, shallow: true, except: :index
  end
end
