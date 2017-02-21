Rails.application.routes.draw do
  get 'accounts/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#  get 'home/index'
#  root 'home#index'

 #get '/about' => 'home#about'
  resources :users
  resources :admins
  resources :transactions
  resources :accounts

  root :to => "home#login"

  get "signup", :to => "users#index"
  post "users", :to => "users#create"
  get "login", :to => "home#login"
  post "login_attempt", :to => "home#login_attempt"
  get "logout", :to => "home#logout"

  get "index", :to => "home#index"
  get "userhome", :to => "home#userhome"
  get "home", :to => "home#userhome"

  get "accounts", :to => "accounts#index"

  # post '/questions' => 'home#temp'
  # post '/answers' => 'home#temp'
  #
  # get '/questions/:id' => 'home#question'

end
