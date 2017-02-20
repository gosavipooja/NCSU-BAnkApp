class Admin < ApplicationRecord

  attr_accessor :password_field

  EMAIL_PATTTERN_FORMAT = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_PATTTERN_FORMAT

  validates :password_field, :presence => true

  validates_length_of :password_field, :in => 5..15, :on => :create

  validates :name, :presence => true

  before_save :encrypt_password, :default_values

  protected

  def encrypt_password
    self.password_digest = Digest::SHA1.hexdigest(password_field).to_s
  end

  def default_values
    is_pre_admin = false
    true
  end

  def self.authenticate(email="", entered_password="")
    admin = Admin.find_by_email(email)
    if admin && admin.match_password(entered_password)
      return admin
    else
      return false
    end
  end

  def self.getadmin(id="")
    admin = Admin.find_by_id(id)
    return admin
  end

  public
  def match_password(entered_password="")
    password_digest == Digest::SHA1.hexdigest(entered_password).to_s
  end
end

