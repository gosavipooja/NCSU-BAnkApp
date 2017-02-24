require 'digest/sha1'

class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]


  def index
    @admins = Admin.all
  end

  def create
    @admin = Admin.new(admin_param)
    # if !session[:is_admin] && user.is_admin
    #   redirect_to :action => :index
    # else
      if @admin.save
        redirect_to :controller => 'home', :action => 'adminhome'
      else
        flash[:notice]="Please enter valid email id or password"
        redirect_to :controller => 'admins', :action => 'create'
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
    redirect_to :action => "index", :controller => "accounts"
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

  def updateprofile
    @admin = Admin.authenticate(params[:admin][:email], params[:admin][:old_password_field])

    if (@admin.id != session[:user_id])
      flash[:notice]="Invalid email id entered"
      redirect_to :controller => 'admins', :action => 'edit'
      return
    end

    if (@admin)
      if @admin.update(admin_param)
        flash[:notice]="Profile updated"
        redirect_to :controller => 'home', :action => 'adminhome'
      else
        flash[:notice]="Please enter valid password"
        redirect_to :controller => 'admins', :action => 'edit'
      end
    else
      flash[:notice]="Please enter valid email id and password"
      redirect_to :controller => 'admins', :action => 'edit'
    end
  end

  def destroy
        @admin = Admin.find(params[:id])
#        is_admin = @member.is_admin
        @admin.destroy
        #Reservation.where(:userid => params[:id]).destroy_all
        redirect_to :action => :show_admin
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_param
    params.require(:admin).permit(:name, :email, :password_field, :is_pre_admin)
  end

  private



end