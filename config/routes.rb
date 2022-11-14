Rails.application.routes.draw do
  resources :plots, only: [:index] do
    resources :plant_plots, only: [:destroy]
  end
  resources :gardens, only: [:show]
end
