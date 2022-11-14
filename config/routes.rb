Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :plots, only: [:index] do
    resources :plot_plants, only: [:destroy]
  end
  resources :gardens, only: [:show]

end
