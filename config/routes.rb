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
  post '/scholarships/:id/create_admin_note' => 'scholarships#create_admin_note'
  get '/scholarships/:id/internship_files' => 'scholarships#internship_files'
  get '/scholarships/:id/student_files' => 'scholarships#student_files'

  post '/scholarships/:id/upload_internship_file' => 'scholarships#upload_internship_file'
    post '/scholarships/:id/upload_student_file' => 'scholarships#upload_student_file'

  post '/scholarships/:id/upload_scholarship_file' => 'scholarships#upload_scholarship_file'
  post '/scholarships/:id/upload_internship_file_with_token' => 'scholarships#upload_internship_file_with_token'
  post '/scholarships/:id/send_to_committee' => 'scholarships#send_to_committee'
  patch '/scholarships/:id/change_status' => 'scholarships#change_status'
  get '/scholarship_files/:id' => 'scholarships#get_scholarship_file'
  delete '/scholarship_files/:id' => 'scholarships#delete_scholarship_file'

  ########################################## home
  get '/load_scholarships' => 'home#load_scholarships'

  ########################################## estadísticas
  get '/stats' => 'stats#index'

  ########################################## notificaciones
  get '/notifications' => 'notifications#index'
  get '/notifications/:id' => 'notifications#show'

  ########################################## UMA's
  post '/update_uma_value' => 'scholarship_types#update_uma'

end
