Rails.application.routes.draw do
  get 'accounts/index'
  get 'admins/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#  get 'home/index'
#  root 'home#index'
  resources :admins, only: [:index, :edit, :view, :show] do
    get :adminsindex ,on: :collection
  end

 #get '/about' => 'home#about'
  resources :users
  resources :transactions
  resources :accounts

  root :to => "home#login"

  get "signup", :to => "users#index"
  post "users", :to => "users#create"
  get "login", :to => "home#login"
  post "login_attempt", :to => "home#login_attempt"
  get "logout", :to => "home#logout"

  get "index", :to => "home#index"
  get "adminhome", :to => "home#adminhome"
  get "home", :to => "home#userhome"

  get "accounts", :to => "accounts#index"
  get "admins", :to => "admins#index"
  get "accountsrequest", :to=> "accounts#accountrequest"
  get "userslist", :to => "users#userslist"
  get "admins", :to => "admins#show"

  get "transactionslist", :to => "transactions#transactionslist"
  # post '/questions' => 'home#temp'
  # post '/answers' => 'home#temp'
  #
  # get '/questions/:id' => 'home#question'

end
