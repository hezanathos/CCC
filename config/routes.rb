# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pirate/new'
  root to: 'pirate#index'
  get  '/create', to: 'pirate#new'
  post '/pirate/:id1/pirate/:id2', to: 'pirate#fight'
  get '/pirate/:id1/pirate/:id2', to: 'pirate#fight'
  resources :pirate
end
