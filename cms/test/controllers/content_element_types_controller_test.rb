require 'test_helper'

class ContentElementTypesControllerTest < ActionController::TestCase
  setup do
    @content_element_type = content_element_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_element_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content_element_type" do
    assert_difference('ContentElementType.count') do
      post :create, content_element_type: { badge: @content_element_type.badge, content_type_id: @content_element_type.content_type_id, field_type: @content_element_type.field_type, mandatory: @content_element_type.mandatory, meta: @content_element_type.meta, name: @content_element_type.name, position: @content_element_type.position, ref_id: @content_element_type.ref_id }
    end

    assert_redirected_to content_element_type_path(assigns(:content_element_type))
  end

  test "should show content_element_type" do
    get :show, id: @content_element_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content_element_type
    assert_response :success
  end

  test "should update content_element_type" do
    patch :update, id: @content_element_type, content_element_type: { badge: @content_element_type.badge, content_type_id: @content_element_type.content_type_id, field_type: @content_element_type.field_type, mandatory: @content_element_type.mandatory, meta: @content_element_type.meta, name: @content_element_type.name, position: @content_element_type.position, ref_id: @content_element_type.ref_id }
    assert_redirected_to content_element_type_path(assigns(:content_element_type))
  end

  test "should destroy content_element_type" do
    assert_difference('ContentElementType.count', -1) do
      delete :destroy, id: @content_element_type
    end

    assert_redirected_to content_element_types_path
  end
end
