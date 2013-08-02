require 'test_helper'

class BranchRoutesControllerTest < ActionController::TestCase
  setup do
    @branch_route = branch_routes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:branch_routes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create branch_route" do
    assert_difference('BranchRoute.count') do
      post :create, branch_route: { branch_id: @branch_route.branch_id, jump: @branch_route.jump, language_id: @branch_route.language_id, name: @branch_route.name, route: @branch_route.route }
    end

    assert_redirected_to branch_route_path(assigns(:branch_route))
  end

  test "should show branch_route" do
    get :show, id: @branch_route
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @branch_route
    assert_response :success
  end

  test "should update branch_route" do
    patch :update, id: @branch_route, branch_route: { branch_id: @branch_route.branch_id, jump: @branch_route.jump, language_id: @branch_route.language_id, name: @branch_route.name, route: @branch_route.route }
    assert_redirected_to branch_route_path(assigns(:branch_route))
  end

  test "should destroy branch_route" do
    assert_difference('BranchRoute.count', -1) do
      delete :destroy, id: @branch_route
    end

    assert_redirected_to branch_routes_path
  end
end
