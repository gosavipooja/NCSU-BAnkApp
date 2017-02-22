require 'digest/sha1'

class AdminsController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @admin = Admin.all
  end

  def create
    @admin = Admin.new(admin_param)
    # if !session[:is_admin] && user.is_admin
    #   redirect_to :action => :index
    # else
      if @admin.save
        redirect_to :controller => 'home', :action => 'login'
      else
        flash[:notice]="Please enter valid email id or password"
        redirect_to :action => :index
      end
  end
  
  def edit
#    @admin = Admin.find(params[:id])
  end
  
  def adminsindex 
    redirect_to :action => :adminsindex
    #@admin = Admin.find(params[:id])
  end

  def view 
    #redirect_to :action => :viewadmins
    #@admin = Admin.find(params[:id])
  end

  def adminstrans
    redirect_to :action => :adminstrans
  end  


  def adminview
      # manage_customers
      # redirect_to manage_customers_administrator_path
      # render "_manage_customers"
  end

  def manage_accounts
  end

  def new
    admin = Admin.new
  end

  def create_admin
    @admin = Admin.new
  end

  def show
    
    if session[:user_id]
      @admins = Admin.find_by_sql(["select * from admins"])  
    else
      redirect_to :action => "login", :controller => "sessions"
end
  end


  def show_admin
    if session[:admin_id]
      @admin = Admin.where("is_admin = true")
    else
      redirect_to :action => "login", :controller => "home"
    end
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_param
    params.require(:admin).permit(:name, :email, :password_field, :address)
  end

  private

  def set_member
    @admin = Admin.find(params[:id])
  end
end