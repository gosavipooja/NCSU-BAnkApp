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

  def show
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
      if amount <= Account.find_by_account_number(debited_acc_number).balance
        if transaction_type == "Withdraw" && amount > 1000
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
      @transaction.transaction_status = "Complete"
    end

    if flag
      if @transaction.save
        puts "Save successful"

        if(transaction_type == "Transfer")
          debited_acc = Account.find_by_account_number(debited_acc_number)
          credited_acc = Account.find_by_account_number(credited_acc_number)
          credited_acc.balance = credited_acc.balance + amount
          debited_acc.balance = debited_acc.balance - amount
          if debited_acc.save && credited_acc.save
            puts "Transaction completed"
          else
            puts "Trouble completing transaction"
          end
        elsif(transaction_type == "Withdraw")
          if(amount < 1000)
            debited_acc = Account.find_by_account_number(debited_acc_number)
            debited_acc.balance = debited_acc.balance - amount
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
          debited_acc.balance = debited_acc.balance + amount
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


  def dotransaction

  end

  def onaccountselection
    @accountselected = params[:transactions][:account]
  end

  def transaction_params
    params.require(:transaction).permit(:account, :transaction_type, :beneficiary_account, :amount)
  end

end
