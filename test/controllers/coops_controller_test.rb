require 'test_helper'

class CoopsControllerTest < ActionController::TestCase
  setup do
    @coop = coops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coop" do
    assert_difference('Coop.count') do
      post :create, coop: { name: @coop.name }
    end

    assert_redirected_to coop_path(assigns(:coop))
  end

  test "should show coop" do
    get :show, id: @coop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coop
    assert_response :success
  end

  test "should update coop" do
    patch :update, id: @coop, coop: { name: @coop.name }
    assert_redirected_to coop_path(assigns(:coop))
  end

  test "should destroy coop" do
    assert_difference('Coop.count', -1) do
      delete :destroy, id: @coop
    end

    assert_redirected_to coops_path
  end
end
