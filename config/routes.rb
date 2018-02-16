Rails.application.routes.draw do

  root 'home#index'
  resources :scholarship_types
  resources :users

  ########################################## sesiones
  get 'login' => 'login#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/logout' => 'sessions#destroy'

  ########################################## becas
  resources :scholarships
  get '/scholarships/:id/formato_solicitud' => 'scholarships#internship_request_file'
  post '/scholarships/:id/create_comment' => 'scholarships#create_comment'

end
