Rails.application.routes.draw do
  get 'sessions/create'
 # localhost:3000/users
 #get '/users', to: 'users#index'

 # localhost:3000/users/1
 #get '/users/:id', to: 'users#show'

 # localhost:3000/users
 #post '/users', to: 'users#create'

 # localhost:3000/users/1
 #put '/users/:id', to: 'users#update'

 # localhost:3000/users/1
 #put '/users/:id', to: 'users#destroy'

 scope '/' do
   post 'login', to: 'sessions#create'
 end

 resources :users do
    get 'posts', to: 'users#posts_index'
 end

 resources :posts
 resources :events
end
