Rails.application.routes.draw do
 # localhost:3000/users
 get '/users', to: 'users#index'
end
