Rails.application.routes.draw do
  get '/main' => 'users#index'
  post '/user/create' => 'users#create_user'
  post '/user/create_returning_user' => 'users#create_returning_user'
  get '/songs' => 'users#show'
  get '/songs/:id' => 'users#show_users'
  get '/users/:id' => 'users#show_playlist'
  post '/create_song/:id' => 'users#create_song'
  patch '/add_song/:id' => 'users#add_song'
  delete '/user/session' => 'users#delete_session'
end
