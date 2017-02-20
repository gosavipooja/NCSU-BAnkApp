class BeneficiaryTable < ApplicationRecord

  EMAIL_PATTTERN_FORMAT = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  validates :email, :presence => true, :format => EMAIL_PATTTERN_FORMAT
  validates :beneficiary_acc_number, :presence => true
  validates_length_of :beneficiary_acc_number, :in => 1..9, :on => :create
  validates :beneficiary_nick_name,  :presence => true

end