class HomeController < ApplicationController
  def index
  end

  def about
  end

  def login
    if session[:user_id]
      redirect_to(:action => 'adminhome')
 #     redirect_to(:action => 'userhome')
    end
  end

  def logout
    session[:user_id] = nil
    session[:name] = nil
    session[:email] = nil
    session[:is_admin] = nil
    flash[:notice] = "Log out successful"
    render "login"
  end

  def newaccountrequest
    @newrequest = AccountCreationRequest.new()
    @newrequest.email = session[:email]
    @newrequest.status = "pending"
    if @newrequest.save
      flash[:notice]="New account request initiated"
      render 'userhome'
      puts "Save Successful"
    else
      flash[:notice]="Problem creating new accounts creation request"
      render 'userhome'
    end

  end


  def login_attempt
    if session[:user_id]
      if session[:is_admin]
        redirect_to(:action => 'adminhome')
      else
        redirect_to(:action => 'userhome')
      end

    else
      authorized_user = Admin.authenticate(params[:user][:email], params[:user][:password])

      if authorized_user
        #admin login
        session[:user_id] = authorized_user.id
        session[:name] = authorized_user.name
        session[:email] = authorized_user.email
        session[:is_admin] = true
        redirect_to(:action => 'adminhome')

      else
        #user login
        authorized_user = User.authenticate(params[:user][:email], params[:user][:password])
        if authorized_user
          session[:user_id] = authorized_user.id
          session[:name] = authorized_user.name
          session[:email] = authorized_user.email
          session[:is_admin] = false
          redirect_to(:action => 'userhome')
        else
          flash[:notice] = "Invalid Username or Password"
          render "login"
        end
      end
    end
  end

  def temp
    redirect_to root_path
  end

  # user home page section

  

  def userhome
    @accounts = Account.all
    @accounts.each do |acc|
      if session[:email] == acc.email
        session[:selected_acc_number] = acc
        break
      end
    end

    if session[:selected_acc_number]
      populate_transfers

      #redirect_to :action => 'userhome'
    end
    #newaccountrequest
  end

  def adminhome

  end

  def request_params
    params.require(:account_creation_request).permit(:email, :status )
  end

  def create
    session[:selected_acc_number] = params[:account].to_i
    populate_transfers
    #redirect_to :action => 'userhome'
  end

  def populate_transfers
    trs = Transaction.all
    @transfers = Array.new
    trs.each do |transaction|
        if session[:selected_acc_number] == transaction.credited_acc_number || session[:selected_acc_number] == transaction.debited_acc_number
          transfer = Transfer.new
          transfer.setstuff(session[:selected_acc_number],
                                transaction.transaction_type,
                                transaction.transaction_status,
                                transaction.credited_acc_number,
                                transaction.debited_acc_number,
                                transaction.amount,
                                0)       #balance= 0
          puts transfer.debited_amount
          @transfers.push transfer
        end
    end
    puts @transfers.length

  end
end