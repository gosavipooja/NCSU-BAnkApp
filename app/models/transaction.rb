class Transaction < ApplicationRecord
  validates :transaction_id, :presence => true
  validates :amount, :presence => true
# validates :admin_email, :presence => true
  EMAIL_PATTTERN_FORMAT = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :admin_email, :format => EMAIL_PATTTERN_FORMAT #, :presence => true

  validates :credited_acc_number, :presence => true
  validates_length_of :credited_acc_number, :in => 1..9, :on => :create
  validates :debited_acc_number, :presence => true
  validates_length_of :debited_acc_number, :in => 1..9, :on => :create
# validates :transaction_status, :presence => true
  validates :transaction_type, :presence => true

  before_save :default_values

  def default_values
    if !transaction_status
      transaction_status = "Pending"
    end
    true
  end
end