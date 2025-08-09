require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "visit dashboard without login" do
    get dashboard_index_path
    assert_redirected_to login_path
  end

  test "visit dashboard when login" do
    login_as users(:one)
    get dashboard_index_path
    assert_response :success
  end
end
