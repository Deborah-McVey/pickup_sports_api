Rails.application.routes.draw do
  scope '/' do
   post 'login', to: 'sessions#create'
 end

 resources :events

 scope :profiles do
  get 'user_name', to: "profiles#show"
 end

 resources :posts

 resources :users do
  get 'posts', to: 'users#posts_index'
  end

end
