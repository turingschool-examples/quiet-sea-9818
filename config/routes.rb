Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :plots, only: [:index, :show, :destroy]

resources :plants, only: [:index, :show, :destroy]

resources :gardens, only: [:index, :show, :destroy]

resources :plot_plants, only: [:index, :show, :destroy]


end
