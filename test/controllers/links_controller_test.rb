require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  test "visit links without login" do
    get links_path
    assert_redirected_to login_path
  end

  test "visit links when login" do
    login_as users(:one)
    get links_path
    assert_response :success
  end

  test "add new valid link" do
    login_as users(:one)
    assert_difference "Link.count" do
      post links_path, params: { link: { url: "http://example.com", slug: "slug" } }
      assert_redirected_to links_path
    end
  end

  test "add new invalid link" do
    login_as users(:one)
    assert_no_difference "Link.count" do
      post links_path, params: { link: { url: "http://example.com", slug: "" } }
      assert_response :unprocessable_content
    end
  end
end
