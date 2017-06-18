require 'test_helper'

class FrontControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get front_index_url
    assert_response :success
  end

end
