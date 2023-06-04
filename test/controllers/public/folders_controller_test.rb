require "test_helper"

class Public::FoldersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_folders_index_url
    assert_response :success
  end

  test "should get show" do
    get public_folders_show_url
    assert_response :success
  end
end
