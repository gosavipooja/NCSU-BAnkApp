class HomeController < ApplicationController
  def index
  end

  def about
  end

  def login
    if session[:user_id]
      redirect_to(:action => 'userhome')
      #redirect_to(:action => 'userhome')
    end
  end

  def logout
    session[:user_id] = nil
    session[:name] = nil
    session[:email] = nil
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

#######this section requires attention
  def login_attempt
    authorized_user = User.authenticate(params[:user][:email], params[:user][:password])
    if session[:user_id]
      redirect_to(:action => 'userhome')
    #end
    elsif authorized_user
      session[:user_id] = authorized_user.id
      session[:name] = authorized_user.name
      session[:email] = authorized_user.email

      # find a way to differentiate between admin and user and login to appropriate page
      redirect_to(:action => 'userhome')

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
    # transactions.each do |transaction|
    #   if session[:selected_acc_number] == transaction.credited_acc_number || session[:selected_acc_number] == transaction.debited_acc_number
    #      transfer = Transfer.new(session[:selected_acc_number],
    #                              transaction.transaction_type,
    #                              transaction.transaction_status,
    #                              transaction.credited_acc_number,
    #                              transaction.debited_acc_number,
    #                              transaction.amount,
    #                              0)       #balance= 0
    #      @transfers.push(transfer)
    #     puts transfer
    #   end
    # end
    # def session_params
  #   params.require(:session).permit(:date, :size, :building, :time)

    #render json: @transfers
  end
end