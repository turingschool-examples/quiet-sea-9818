Rails.application.routes.draw do
  resources :gardens, only: [:show] do 
    resources :plots, only: [:index]
  end
end
