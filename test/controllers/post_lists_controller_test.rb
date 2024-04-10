require "test_helper"

class PostListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get post_lists_index_url
    assert_response :success
  end

  test "should get show" do
    get post_lists_show_url
    assert_response :success
  end
end
