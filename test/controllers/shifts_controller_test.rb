require 'test_helper'

class ShiftsControllerTest < ActionController::TestCase
  setup do
    @shift = shifts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shifts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shift" do
    assert_difference('Shift.count') do
      post :create, shift: { activity: @shift.activity, coop_id: @shift.coop_id, end_time: @shift.end_time, leader: @shift.leader, start_time: @shift.start_time }
    end

    assert_redirected_to shift_path(assigns(:shift))
  end

  test "should show shift" do
    get :show, id: @shift
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shift
    assert_response :success
  end

  test "should update shift" do
    patch :update, id: @shift, shift: { activity: @shift.activity, coop_id: @shift.coop_id, end_time: @shift.end_time, leader: @shift.leader, start_time: @shift.start_time }
    assert_redirected_to shift_path(assigns(:shift))
  end

  test "should destroy shift" do
    assert_difference('Shift.count', -1) do
      delete :destroy, id: @shift
    end

    assert_redirected_to shifts_path
  end
end
