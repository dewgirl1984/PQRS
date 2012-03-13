require 'test_helper'

class QrContentPlacementsControllerTest < ActionController::TestCase
  setup do
    @qr_content_placement = qr_content_placements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qr_content_placements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qr_content_placement" do
    assert_difference('QrContentPlacement.count') do
      post :create, qr_content_placement: @qr_content_placement.attributes
    end

    assert_redirected_to qr_content_placement_path(assigns(:qr_content_placement))
  end

  test "should show qr_content_placement" do
    get :show, id: @qr_content_placement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qr_content_placement
    assert_response :success
  end

  test "should update qr_content_placement" do
    put :update, id: @qr_content_placement, qr_content_placement: @qr_content_placement.attributes
    assert_redirected_to qr_content_placement_path(assigns(:qr_content_placement))
  end

  test "should destroy qr_content_placement" do
    assert_difference('QrContentPlacement.count', -1) do
      delete :destroy, id: @qr_content_placement
    end

    assert_redirected_to qr_content_placements_path
  end
end
