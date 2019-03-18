# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  get '/admin', to: 'forced_rates#new'
  post '/admin', to: 'forced_rates#create'

  require 'sidekiq/web'
  # require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'
end
