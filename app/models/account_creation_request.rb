class AccountCreationRequest < ApplicationRecord

  attr_accessor :admin_email
  EMAIL_PATTTERN_FORMAT = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email, :presence => true, :format => EMAIL_PATTTERN_FORMAT
  validates :status, :presence => true
end
