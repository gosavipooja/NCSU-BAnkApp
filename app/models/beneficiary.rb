class Beneficiary < ApplicationRecord

  EMAIL_PATTTERN_FORMAT = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  validates :email, :presence => true, :format => EMAIL_PATTTERN_FORMAT
  validates :account, :presence => true
  validates_length_of :account, :in => 1..9, :on => :create
  validates :nickname,  :presence => true
  # def initialize(email, account, nickname)
  #   @email=email
  #   @account =account
  #   @nickname =nickname
  # end

end
