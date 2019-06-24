require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get microposts_new_url
    assert_response :success
  end

  test "should get index" do
    get microposts_index_url
    assert_response :success
  end

end
