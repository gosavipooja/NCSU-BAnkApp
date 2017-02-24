class Account < ApplicationRecord
  attr_accessor :account_status
  validates :email,  :presence => true
  validates :account_number, :presence => true, :uniqueness => true
  validates_length_of :account_number, :in => 1..9, :on => :create
  validates :balance,  :presence => true

  # before_save :default_values
  #
  # def default_values
  #   if !@balance
  #     @balance = 0
  #   end
  #   if !account_status
  #     account_status = true
  #   end
  #   true
  # end

  def self.match(email="", number=0)
    #account = Account.find_by_sql(["select * from Accounts where account_number = :id ", {:id => number}])
    #email == account.email
    account = Account.find_by_account_number(number)
    if account
      email == account.email
    else
      return false
    end
  end

end