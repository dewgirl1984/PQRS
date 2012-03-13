require 'test_helper'

class QrCollectionPlacementsControllerTest < ActionController::TestCase
  setup do
    @qr_collection_placement = qr_collection_placements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qr_collection_placements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qr_collection_placement" do
    assert_difference('QrCollectionPlacement.count') do
      post :create, qr_collection_placement: @qr_collection_placement.attributes
    end

    assert_redirected_to qr_collection_placement_path(assigns(:qr_collection_placement))
  end

  test "should show qr_collection_placement" do
    get :show, id: @qr_collection_placement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qr_collection_placement
    assert_response :success
  end

  test "should update qr_collection_placement" do
    put :update, id: @qr_collection_placement, qr_collection_placement: @qr_collection_placement.attributes
    assert_redirected_to qr_collection_placement_path(assigns(:qr_collection_placement))
  end

  test "should destroy qr_collection_placement" do
    assert_difference('QrCollectionPlacement.count', -1) do
      delete :destroy, id: @qr_collection_placement
    end

    assert_redirected_to qr_collection_placements_path
  end
end
