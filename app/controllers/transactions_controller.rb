class TransactionsController < ApplicationController
  def index
    @accounts = Account.all
    @beneficiaries = Beneficiary.all
    @accountselected = Account.first
  end

  def transactionslist
    @trans = Transaction.all
    render "transactionslist"
  end

  def create
    debited_acc_number = params[:account].to_i
    transaction_type = params[:transaction][:transaction_type]
    credited_acc_number = params[:beneficiary_account].to_i
    amount = params[:transaction][:amount].to_i
    @transaction = Transaction.new#debited_acc_number, transaction_type, beneficiary_account, amount

    @transaction.transaction_id = SecureRandom.uuid
    @transaction.debited_acc_number = debited_acc_number
    @transaction.transaction_type = transaction_type
    @transaction.credited_acc_number = credited_acc_number
    @transaction.amount = amount
    @transaction.admin_email = "admin@admin.com"
    flag = true

    if transaction_type != "Deposit"
      account =  Account.find_by_account_number(debited_acc_number)
      balance = 0
      if account && account.balance
        balance = account.balance
      else
        balance = 0
      end
      if amount <= balance
        if transaction_type == "Withdraw"  && amount > 1000
          @transaction.transaction_status = "Pending"
        else
          @transaction.transaction_status = "Complete"
        end
      else
        flag = false
        flash[:notice]="Insufficient Balance"
        redirect_to :action => :index
      end
    else
      @transaction.transaction_status = "Pending"
    end


    if flag
      if @transaction.save
        puts "Save successful"

        if(transaction_type == "Transfer")
          debited_acc = Account.find_by_account_number(debited_acc_number)
          credited_acc = Account.find_by_account_number(credited_acc_number)
          if credited_acc.balance
            credited_acc.balance = credited_acc.balance + amount
          else
            credited_acc.balance = amount
          end
          if debited_acc.balance
            debited_acc.balance = debited_acc.balance - amount
          else
            debited_acc.balance = 0 - amount
          end

          if debited_acc.save && credited_acc.save
            puts "Transaction completed"
          else
            puts "Trouble completing transaction"
          end
        elsif(transaction_type == "Withdraw")
          if(amount < 1000)
            debited_acc = Account.find_by_account_number(debited_acc_number)
            if debited_acc.balance
              debited_acc.balance = debited_acc.balance - amount
            else
              debited_acc.balance = 0 - amount
            end
            if debited_acc.save
              puts "Transaction completed"
            else
              puts "Trouble completing transaction"
            end
          else
            puts @transaction.transaction_status
            flash[:notice]="Transfer pending Bank's approval"
            #@transaction.save
          end

        else
          debited_acc = Account.find_by_account_number(debited_acc_number)
          if debited_acc.balance
            debited_acc.balance = debited_acc.balance + amount
          else
            debited_acc.balance = amount
          end
          if debited_acc.save

            puts "Transaction completed"
          else
            puts "Trouble completing transaction"
          end
        end
        flash[:notice]="Transfer initiated"
        redirect_to :controller => 'home', :action => 'userhome'
      else
        flash[:notice]="Transaction failed"
        redirect_to :action => :index
      end
    end
    #puts "Error message " + @transaction.errors.messages.inspect
  end

  def approve
    @transaction = Transaction.find(params[:id])
    @transaction.transaction_status = "Complete"

    if @transaction.transaction_type == "Withdraw"
      debited_acc = Account.find_by_account_number(@transaction.debited_acc_number)
      if debited_acc.balance
        debited_acc.balance = debited_acc.balance - @transaction.amount
      else
        debited_acc.balance = 0 - @transaction.amount
      end
      @transaction.transaction_status = "Complete"
      if @transaction.save &&  debited_acc.save
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        puts "Transaction completed"
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
      else
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        puts "Trouble completing transaction"
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
      end
    else
      debited_acc = Account.find_by_account_number(@transaction.debited_acc_number)
      if debited_acc.balance
        debited_acc.balance = debited_acc.balance + @transaction.amount
      else
        debited_acc.balance = @transaction.amount
      end
      @transaction.transaction_status = "Complete"
      if @transaction.save && debited_acc.save
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        puts "Transaction completed"
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
      else
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        puts "Trouble completing transaction"
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
      end
    end
    redirect_to :action => 'transactionslist'
  end

  def destroy
    @transaction = Transaction.find(params[:id])

    @transaction.transaction_status = "Cancelled"
    if @transaction.save
      #puts "@request.status = Cancelled ---------------- save successful"
      flash[:notice]="Transaction cancelled"
      redirect_to :action => 'transactionslist'
    else
     # puts "@request.status = Cancelled ---------------- save unsuccessful"
      flash[:notice]="Trouble cancelling request"
      redirect_to :action => 'transactionslist'
    end
  end

  def dotransaction

  end

  def onaccountselection
    @accountselected = params[:transactions][:account]
  end

  def transaction_params
    params.require(:transaction).permit(:account, :transaction_type, :beneficiary_account, :amount)
  end

end
