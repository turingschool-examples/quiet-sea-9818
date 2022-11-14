Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :plots, only: [:index] do
    resources :plants, only: [:destroy], controller: "plot_plants"
  end

end
