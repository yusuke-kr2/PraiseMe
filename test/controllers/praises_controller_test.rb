require "test_helper"

class PraisesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get praises_index_url
    assert_response :success
  end
end
