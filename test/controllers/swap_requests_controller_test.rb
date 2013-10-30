require 'test_helper'

class SwapRequestsControllerTest < ActionController::TestCase
  setup do
    @swap_request = swap_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:swap_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create swap_request" do
    assert_difference('SwapRequest.count') do
      post :create, swap_request: { date: @swap_request.date, headcook_required: @swap_request.headcook_required, isResolved?: @swap_request.isResolved?, message: @swap_request.message }
    end

    assert_redirected_to swap_request_path(assigns(:swap_request))
  end

  test "should show swap_request" do
    get :show, id: @swap_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @swap_request
    assert_response :success
  end

  test "should update swap_request" do
    patch :update, id: @swap_request, swap_request: { date: @swap_request.date, headcook_required: @swap_request.headcook_required, isResolved?: @swap_request.isResolved?, message: @swap_request.message }
    assert_redirected_to swap_request_path(assigns(:swap_request))
  end

  test "should destroy swap_request" do
    assert_difference('SwapRequest.count', -1) do
      delete :destroy, id: @swap_request
    end

    assert_redirected_to swap_requests_path
  end
end
