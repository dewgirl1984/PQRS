require 'test_helper'

class QrcontentsControllerTest < ActionController::TestCase
  setup do
    @qrcontent = qrcontents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qrcontents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qrcontent" do
    assert_difference('Qrcontent.count') do
      post :create, qrcontent: @qrcontent.attributes
    end

    assert_redirected_to qrcontent_path(assigns(:qrcontent))
  end

  test "should show qrcontent" do
    get :show, id: @qrcontent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qrcontent
    assert_response :success
  end

  test "should update qrcontent" do
    put :update, id: @qrcontent, qrcontent: @qrcontent.attributes
    assert_redirected_to qrcontent_path(assigns(:qrcontent))
  end

  test "should destroy qrcontent" do
    assert_difference('Qrcontent.count', -1) do
      delete :destroy, id: @qrcontent
    end

    assert_redirected_to qrcontents_path
  end
end
