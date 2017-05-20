Rails.application.routes.draw do
  get 'pirate/new'
  root to: 'visitors#index'
  get  '/create',  to: 'pirate#new'
  resources :pirate
end
