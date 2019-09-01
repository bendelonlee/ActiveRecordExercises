Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "exercises#index", as: "root"
  get '/auth/google_oauth2', as: 'sign_up'
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  post '/timed_blocks/:exercise_id', to: 'timed_blocks#create', as: 'surrender'
  resources :exercises, only: [:show, :index] do
    resources :solutions, only: [:create]
  end
end
