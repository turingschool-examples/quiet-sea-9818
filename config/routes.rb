Rails.application.routes.draw do
  resources :gardens, only: [:show]
  
  resources :plots, only: [:index] do 
    resources :plants, only: [:destroy], controller: "plant_plots"
  end
end
