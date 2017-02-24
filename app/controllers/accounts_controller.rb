class AccountsController < ApplicationController

  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.all
  end

  def accountsrequest
  	render "accountrequest"
  end

  def create
    @account = Account.new(account_param)
  end

  def accountsindex
    redirect_to :action => :accountsindex
  end

  def create_account
    @account = Account.new
  end

  def show
    if session[:admin_id]
      @accounts = Account.find_by_sql(["select * from accounts"])
    else
      redirect_to :action => "login", :controller => "sessions"
    end
  end
end
