require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Online Bank Application"
    assert_equal full_title("Help"), "Help | Online Bank Application"
  end
end