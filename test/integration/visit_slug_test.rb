require "test_helper"

class VisitSlugTest < ActionDispatch::IntegrationTest
  setup do
    host! "gpr.localhost"
  end

  test "visit valid slug" do
    link = links(:one)

    assert_difference "link.reload.visit_count" do
      get "/#{link.slug}"
      assert_redirected_to link.url
    end
  end

  test "visit invalid slug" do
    get "/random"
    assert_response :not_found
  end
end
