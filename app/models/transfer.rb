class Transfer

  attr_accessor :type, :status, :balance, :debited_amount, :credited_amount, :person, :other_acc_number, :selected_account

  def setstuff(selected_account, type, status, credited_acc_number, debited_acc_number, amount, balance = 0, person ="self" )
    self.type = type
    self.status = status
    self.balance = balance

    self.other_acc_number = credited_acc_number
    if(credited_acc_number != selected_account)
      self.other_acc_number = debited_acc_number
    end

    if self.other_acc_number
      self.person = ""
    end

    case self.type
      when "Transfer"
        if(credited_acc_number == selected_account)
          self.credited_amount = amount
          self.debited_amount = 0
        elsif(debited_acc_number== selected_account)
          self.credited_amount = 0
          self.debited_amount = amount
        else
          self.credited_amount = 0
          self.debited_amount = 0
        end
      when "Deposit"
        self.credited_amount = amount
        self.debited_amount = 0
      else
        self.credited_amount = 0
        self.debited_amount = amount
    end
  end
  # @person
  # @my_acc_number
  # @other_acc_number
  # @credited_amount
  # @debited_amount
  # @status
  # @balance
end