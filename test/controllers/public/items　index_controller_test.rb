require "test_helper"

class Public::Items　indexControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_items　index_show_url
    assert_response :success
  end
end
