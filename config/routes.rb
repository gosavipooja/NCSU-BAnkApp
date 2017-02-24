Rails.application.routes.draw do
  get 'transactions/index'

  get 'transaction/index'

  get 'beneficiary/index'

  get 'beneficiaries/index'

  get 'transfers/index'

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
  get "accountsrequest", :to => "home#newaccountrequest"
  get "beneficiaries", :to => "beneficiaries#index"
  get "beneficiaries/new", :to => "beneficiaries#new"
  post "beneficiaries", :to => "beneficiaries#create"

  post "transactions", :to => "transactions#create"

  delete "beneficiaries/:id", :to => "beneficiaries#destroy"
  # get "delete", :to => "beneficiaries#destroy"
  # get "deletebeneficiary", :to => "beneficiaries#delete"
  # post "deletebeneficiary", :to => "beneficiaries#delete"

  get "onaccountselection", :to => "transactions#onaccountselection"

  #delete "beneficiaries" => "beneficiaries#destroy"
  # resources :beneficiaries, :only => [:new, :create]
  #match '/beneficiaries' => 'beneficiaries#new', :via => :post
  # resources :beneficiaries do
  #   collection do
  #     get 'showall'
  #   end
  # end


  #get "accounts/request" , :to => "accounts#request"


  get "transfers", :to => "transfers#index"
  get "transfers", :to => "transactions#index"
  get "usersettings", :to => "users#settings"
  get "usersprofile", :to => "users#profile"
  #get "settings", :to => "users#settings"

  post "update", :to => "users#updateprofile"

end
