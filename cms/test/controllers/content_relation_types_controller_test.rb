require 'test_helper'

class ContentRelationTypesControllerTest < ActionController::TestCase
  setup do
    @content_relation_type = content_relation_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_relation_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content_relation_type" do
    assert_difference('ContentRelationType.count') do
      post :create, content_relation_type: { content_type_id: @content_relation_type.content_type_id, intern: @content_relation_type.intern, name: @content_relation_type.name, project_id: @content_relation_type.project_id, relation_type: @content_relation_type.relation_type, relative_type_id: @content_relation_type.relative_type_id }
    end

    assert_redirected_to content_relation_type_path(assigns(:content_relation_type))
  end

  test "should show content_relation_type" do
    get :show, id: @content_relation_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content_relation_type
    assert_response :success
  end

  test "should update content_relation_type" do
    patch :update, id: @content_relation_type, content_relation_type: { content_type_id: @content_relation_type.content_type_id, intern: @content_relation_type.intern, name: @content_relation_type.name, project_id: @content_relation_type.project_id, relation_type: @content_relation_type.relation_type, relative_type_id: @content_relation_type.relative_type_id }
    assert_redirected_to content_relation_type_path(assigns(:content_relation_type))
  end

  test "should destroy content_relation_type" do
    assert_difference('ContentRelationType.count', -1) do
      delete :destroy, id: @content_relation_type
    end

    assert_redirected_to content_relation_types_path
  end
end
