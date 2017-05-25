# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pirate/new'
  root to: 'pirate#index'
  get  '/create', to: 'pirate#new'
  get  '/fight1', to: 'pirate#send_to_fight1'
  get  '/fight2', to: 'pirate#send_to_fight2'
  post  '/pirate/:id/fight1', to: 'pirate#send_to_fight1'
  post  '/pirate/:id/fight2', to: 'pirate#send_to_fight2'
  post  '/shield/:id', to: 'pirate#shield'
  post  '/parrot/:id', to: 'pirate#parrot'
  post '/pirate/:id1/pirate/:id2', to: 'pirate#fight'
  get '/pirate/:id1/pirate/:id2', to: 'pirate#fight'
  resources :pirate
end
