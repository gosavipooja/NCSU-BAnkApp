class AccountCreationRequest < ApplicationRecord

  EMAIL_PATTTERN_FORMAT = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email, :presence => true, :format => EMAIL_PATTTERN_FORMAT

  before_save :default_values

  # def initialize(email)
  #   @email = email
  #   @status = "pending"
  # end

  def default_values
    if !status
      @status = "pending"
    end
    true
  end
end
