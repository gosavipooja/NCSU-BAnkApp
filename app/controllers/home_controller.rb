class HomeController < ApplicationController
  def index
  end

  def about
  end

  def login
    #Login Form
    if session[:user_id]
      redirect_to(:action => 'adminhome')
    end
  end

  def logout
    session[:user_id] = nil
    session[:name] = nil
    session[:email] = nil
    flash[:notice] = "You have been successfully logged out"
    # redirect_to(:action => 'login')
    render "login"
  end

#######this section requires attention
  def login_attempt
    authorized_user = Admin.authenticate(params[:user][:email], params[:user][:password])
    if session[:user_id]
      redirect_to(:action => 'adminhome')
    #end
    elsif authorized_user
      session[:user_id] = authorized_user.id
      session[:name] = authorized_user.name
      session[:email] = authorized_user.email

      # find a way to differentiate between admin and user and login to appropriate page
      redirect_to(:action => 'adminhome')

      # if authorized_user.is_admin
      #   session[:is_admin] = true
      #   redirect_to(:action => 'userhome')
      # else
      #   redirect_to(:action => 'userhome')
      # end
    else
      flash[:notice] = "Invalid Username or Password"
      render "login"
    end
  end

  def temp
    redirect_to root_path
  end

  # user home page section

  

  def userhome

  end

  def adminhome

  end


  # def session_params
  #   params.require(:session).permit(:date, :size, :building, :time)
  # end
end