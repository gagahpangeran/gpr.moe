require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "visit homepage" do
    get root_path
    assert_response :success
  end
end
