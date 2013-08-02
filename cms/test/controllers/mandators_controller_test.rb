require 'test_helper'

class MandatorsControllerTest < ActionController::TestCase
  setup do
    @mandator = mandators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mandators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mandator" do
    assert_difference('Mandator.count') do
      post :create, mandator: { identifizierung: @mandator.identifizierung, muttersprache: @mandator.muttersprache, name: @mandator.name, name_intern: @mandator.name_intern, old_id: @mandator.old_id, optionen: @mandator.optionen, portal_mandator_id: @mandator.portal_mandator_id, sprachen: @mandator.sprachen, status: @mandator.status }
    end

    assert_redirected_to mandator_path(assigns(:mandator))
  end

  test "should show mandator" do
    get :show, id: @mandator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mandator
    assert_response :success
  end

  test "should update mandator" do
    patch :update, id: @mandator, mandator: { identifizierung: @mandator.identifizierung, muttersprache: @mandator.muttersprache, name: @mandator.name, name_intern: @mandator.name_intern, old_id: @mandator.old_id, optionen: @mandator.optionen, portal_mandator_id: @mandator.portal_mandator_id, sprachen: @mandator.sprachen, status: @mandator.status }
    assert_redirected_to mandator_path(assigns(:mandator))
  end

  test "should destroy mandator" do
    assert_difference('Mandator.count', -1) do
      delete :destroy, id: @mandator
    end

    assert_redirected_to mandators_path
  end
end
