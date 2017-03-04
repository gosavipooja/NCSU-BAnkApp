require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: 'User Name', email: 'user@example.com',
                     password: 'password')
  end

  test 'Please Enter a valid user' do
    assert @user.valid?
  end

  test 'Please enter the name' do
    @user.name = '    '
    assert_not @user.valid?
  end

  test 'Please enter an email' do
    @user.email = '   '
    assert_not @user.valid?
  end

  test 'Name is too long' do
    @user.name = 'a' * 25
    assert_not @user.valid?
  end

  test 'Email is too long' do
    @user.email = 'a' * 50 + '@example.com'
    assert_not @user.valid?
  end

  test 'Invalid Email Address' do
    invalid_addresses = %w[user@user,com user_at_example.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'Enter a unique email id' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'Please enter the email id in correct format' do
    mixed_case_email = 'uSeR@TesTUSer.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'Please enter minimum 8 characters for password' do
    @user.password = @user.password_confirmation = 'a' * 8
    assert_not @user.valid?
  end

  test 'Please enter a password' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

end

