require 'test_helper'

class BeneficiaryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get beneficiary_index_url
    assert_response :success
  end

end
