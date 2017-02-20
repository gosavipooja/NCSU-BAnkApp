class Account < ApplicationRecord
  validates :email,  :presence => true
  validates :account_number, :presence => true, :uniqueness => true
  validates_length_of :account_number, :in => 1..9, :on => :create

  before_save :default_values

  def default_values
    if !balance
      balance = 0
    end
    if !account_status
      account_status = true
    end
    true
  end
end