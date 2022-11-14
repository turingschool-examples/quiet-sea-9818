Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# get '/plots', to: 'plots#index'
  delete 'plots', to: 'plots#destroy'
  resources :plots, only: [:index]
  resources :gardens, only: [:show]
end
