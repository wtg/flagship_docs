require 'test_helper'

class RevisionsControllerTest < ActionController::TestCase
  setup do
    @revision = revisions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:revisions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create revision" do
    assert_difference('Revision.count') do
      post :create, :revision => @revision.attributes
    end

    assert_redirected_to revision_path(assigns(:revision))
  end

  test "should show revision" do
    get :show, :id => @revision.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @revision.to_param
    assert_response :success
  end

  test "should update revision" do
    put :update, :id => @revision.to_param, :revision => @revision.attributes
    assert_redirected_to revision_path(assigns(:revision))
  end

  test "should destroy revision" do
    assert_difference('Revision.count', -1) do
      delete :destroy, :id => @revision.to_param
    end

    assert_redirected_to revisions_path
  end
end
