Rails.application.routes.draw do

  resources :users
  resources :scholarships
  root 'home#index'

  ########################################## sesions
  get 'login' => 'login#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/logout' => 'sessions#destroy'

  ##########################################
  get '/internship_data/:id' => 'home#get_internship'

end
