Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ('/')
  # root 'articles#index'
  root 'main#index'
  get '/signup', to: 'sessions#signup'
  post '/signup', to: 'sessions#create'
  get '/signin', to: 'sessions#signin'
  post '/signin', to: 'sessions#verify'
  get '/logout', to: 'sessions#logout'
  get '/:list_id', to: 'main#lists'
  post '/add_list', to: 'main#add_list'
  patch '/edit_list/:list_id', to: 'main#change_list'
  delete '/delete_list/:list_id', to: 'main#delete_list'
  post '/add_todo', to: 'main#add_todo'
  patch '/edit_todo', to: 'main#change_todo'
  patch '/toggle/:todo_id/', to: 'main#toggle_todo_status'
  delete '/delete_todo/:todo_id/', to: 'main#delete_todo'
end
