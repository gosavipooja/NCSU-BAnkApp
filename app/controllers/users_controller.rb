require 'digest/sha1'

class UsersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
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



  def new
    user = User.new
  end

  def create_user
    @user = User.new
  end

  def show_user
    if session[:user_id]
      @users = User.where("is_admin = true")
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
