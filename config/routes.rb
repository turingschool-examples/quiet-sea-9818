Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :plots, except: [:update] 

  resources :plots, except: [:update] do
    resources :plants, except: [:update]
  end
end
