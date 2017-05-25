# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pirate/new'
  root to: 'pirate#index'
  get  '/create', to: 'pirate#new'
  get  '/fight1', to: 'pirate#send_to_fight1'
  get  '/fight2', to: 'pirate#send_to_fight2'
  post  '/fight1/pirate/:id', to: 'pirate#send_to_fight1'
  post  '/fight2/pirate/:id', to: 'pirate#send_to_fight2'
  post '/pirate/:id1/pirate/:id2', to: 'pirate#fight'
  get '/pirate/:id1/pirate/:id2', to: 'pirate#fight'
  resources :pirate
end
