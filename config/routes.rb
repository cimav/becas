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
  get '/scholarships/:id/token/:token' => 'scholarships#access_with_token'
  get '/scholarships/:id/formato_solicitud_cep' => 'scholarships#print_internship_cep_file'
  post '/scholarships/:id/create_comment' => 'scholarships#create_comment'
  get '/scholarships/:id/internship_files' => 'scholarships#internship_files'
  post '/scholarships/:id/upload_internship_file' => 'scholarships#upload_internship_file'
  post '/scholarships/:id/upload_internship_file_with_token' => 'scholarships#upload_internship_file_with_token'
  post '/scholarships/:id/send_to_committee' => 'scholarships#send_to_committee'

  ########################################## home
  get '/load_part_scholarships' => 'home#load_part_scholarships'

end
