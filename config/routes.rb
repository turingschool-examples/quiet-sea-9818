Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :plots

  get "/plots", to: "plots#index"
  get "/plots/:id/plants/:id/destroy", to: "plot_plants#destroy"
  get "gardens/:id", to: "gardens#show"
end
