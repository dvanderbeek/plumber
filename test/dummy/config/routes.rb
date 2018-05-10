Rails.application.routes.draw do
  mount Plumber::Engine => "/plumber"
end
