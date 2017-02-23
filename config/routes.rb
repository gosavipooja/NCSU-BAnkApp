Rails.application.routes.draw do
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
  get "beneficiaries", :to => "beneficiaries#index"
  get "beneficiaries/add", :to => "beneficiaries#add"
  post "beneficiaries" => "beneficiaries#create"
  delete "beneficiaries/:id" => "beneficiaries#destroy"
  # get "delete", :to => "beneficiaries#destroy"
  # get "deletebeneficiary", :to => "beneficiaries#delete"
  # post "deletebeneficiary", :to => "beneficiaries#delete"

  #delete "beneficiaries" => "beneficiaries#destroy"
  # resources :beneficiaries, :only => [:add, :create]
  #match '/beneficiaries' => 'beneficiaries#add', :via => :post
  # resources :beneficiaries do
  #   collection do
  #     get 'showall'
  #   end
  # end

  get "transfers", :to => "transfers#index"
  get "usersettings", :to => "users#settings"
  get "usersprofile", :to => "users#profile"
  #get "settings", :to => "users#settings"

  post "update", :to => "users#updateprofile"

end
