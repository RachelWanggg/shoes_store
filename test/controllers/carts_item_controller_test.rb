require "test_helper"

class CartsItemControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get carts_item_add_url
    assert_response :success
  end

  test "should get remove" do
    get carts_item_remove_url
    assert_response :success
  end
end
