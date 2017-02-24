
class UsersController < ApplicationController
  before_action :user_param, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def userslist
    @users = User.all
    render 'userslist'
  end

  def create
    @user = User.new(user_param)
    # if !session[:is_admin] && user.is_admin
    #   redirect_to :action => :index
    # else
      if @user.save
        redirect_to :controller => 'home', :action => 'login'
      else
        flash[:notice]="Please enter valid email id or password"
        redirect_to :action => :index
      end
    # end
  end

  def updateprofile
    @user = User.authenticate(params[:user][:email], params[:user][:old_password_field])

    if (@user.id != session[:user_id])
      flash[:notice]="Invalid email id entered"
      redirect_to :controller => 'users', :action => 'settings'
      return
    end

    if (@user)
      if @user.update(user_param)
        flash[:notice]="Profile updated"
        redirect_to :controller => 'home', :action => 'userhome'
      else
        flash[:notice]="Please enter valid password"
        redirect_to :controller => 'users', :action => 'settings'
      end
    else
      flash[:notice]="Please enter valid email id and password"
      redirect_to :controller => 'users', :action => 'settings'
    end
  end

  # def usersettings
  #   @user = User.getuser(session[:user_id])
  #   redirect_to :controller => 'users', :action => 'settings'
  # end

  def settings
    @user = User.getuser(session[:user_id])
    render "settings"
  end

  def profile
  @user = User.getuser(session[:user_id])
  render "profile"
end

  def new
    user = User.new
  end

  def create_user
    @user = User.new
  end

  def show_user
    if session[:user_id]
      @users = User.all
    else
      redirect_to :action => "login", :controller => "home"
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_param
    params.require(:user).permit(:name, :email, :password_field, :address)
  end
end
