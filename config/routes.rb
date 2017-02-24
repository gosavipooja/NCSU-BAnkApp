Rails.application.routes.draw do
  get 'transactions/index'

  get 'transaction/index'

  get 'beneficiary/index'

  get 'beneficiaries/index'

  get 'transfers/index'

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
#  resources :accounts
#  resources :admins

  root :to => "home#login"

  get "signup", :to => "users#index"
  post "users", :to => "users#create"
  get "login", :to => "home#login"
  post "login_attempt", :to => "home#login_attempt"
  get "logout", :to => "home#logout"

  get "index", :to => "home#index"
  get "adminhome", :to => "home#adminhome"
  get "userhome", :to => "home#userhome"
  get "go", :to => "home#go"

  get "accounts", :to => "accounts#index"

  get "admins", :to => "admins#index"
  get "useraccountsrequest", :to => "home#useraccountrequest"
  get "accountsrequest", :to=> "accounts#accountrequest"
  get "accounts/create/:id", :to=> "accounts#create"
  get "accounts/delete/:id", :to=> "accounts#destroy"
  #post "accounts/:id", :to => "accounts#create"
  #delete "accounts/:id", :to => "accounts#destroy"

  get "userslist", :to => "users#userslist"
  get "admins", :to => "admins#show"

  get "transactionslist", :to => "transactions#transactionslist"
  # post '/questions' => 'home#temp'
  # post '/answers' => 'home#temp'
  #
  # get '/questions/:id' => 'home#question'

  #get "accountsrequest", :to => "home#newaccountrequest"
  get "beneficiaries", :to => "beneficiaries#index"
  get "beneficiaries/new", :to => "beneficiaries#new"
  post "beneficiaries", :to => "beneficiaries#create"

  post "transactions", :to => "transactions#create"
  post "home", :to => "home#create"

  delete "beneficiaries/:id", :to => "beneficiaries#destroy"

  get "onaccountselection", :to => "transactions#onaccountselection"


  get "transfers", :to => "transfers#index"
  get "transfers", :to => "transactions#index"
  get "usersettings", :to => "users#settings"
  get "usersprofile", :to => "users#profile"
  #get "settings", :to => "users#settings"

  post "update", :to => "users#updateprofile"

  post "updateprofile", :to => "admins#updateprofile"
  get "newadmin", :to => "admins#new"
  get "admins", :to => "admins#create"
  post "admins", :to => "admins#create"


end
