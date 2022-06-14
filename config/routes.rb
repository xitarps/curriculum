# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get '/about', to: 'home#about'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
end
