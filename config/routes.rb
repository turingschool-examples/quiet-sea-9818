Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :plots
  resources :gardens
  delete '/plant_plots/:id', to: 'plant_plots#destroy'
end
