Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :plots, only: [:index]
  resources :plants, only: [:destroy]

  # began doing both nonRESTful and RESTful since directions somewhat amibiguous; destroy works because of the route_helper
  resources :gardens, only: [:show] do
    resources :plots, only: [:index] do
      resources :plants, only: [:destroy], controller: 'plant_plots'
    end
  end
end
