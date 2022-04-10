require 'test_helper'

class VariationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @variation = variations(:one)
  end

  test "should get index" do
    get variations_url
    assert_response :success
  end

  test "should get new" do
    get new_variation_url
    assert_response :success
  end

  test "should create variation" do
    assert_difference('Variation.count') do
      post variations_url, params: { variation: { product_id: @variation.product_id, title: @variation.title } }
    end

    assert_redirected_to variation_url(Variation.last)
  end

  test "should show variation" do
    get variation_url(@variation)
    assert_response :success
  end

  test "should get edit" do
    get edit_variation_url(@variation)
    assert_response :success
  end

  test "should update variation" do
    patch variation_url(@variation), params: { variation: { product_id: @variation.product_id, title: @variation.title } }
    assert_redirected_to variation_url(@variation)
  end

  test "should destroy variation" do
    assert_difference('Variation.count', -1) do
      delete variation_url(@variation)
    end

    assert_redirected_to variations_url
  end
end
