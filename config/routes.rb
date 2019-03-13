Rails.application.routes.draw do
  root to: 'home#index'
  get '/admin', to: 'forced_rates#new'
  post '/admin', to: 'forced_rates#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
