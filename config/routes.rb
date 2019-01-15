Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "exercises#index", as: "root"
  resources :exercises, only: [:show, :index] do
    resources :solutions, only: [:create]
  end
end
