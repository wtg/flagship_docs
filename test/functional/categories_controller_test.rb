require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    ActiveRecord::Base.accessor = nil
    @groupie = users(:groupie)
    @patron = users(:patron)
    @regular = users(:regular)
    @admin = users(:admin)

    @cool_kids = groups(:cool_kids)
    @patroons = groups(:patroons)

    @cat = Category.new({:name => "Root Level", :description => "Root Level Category"})
    @cat.group = @cool_kids
    @cat.user = @patron
    @cat.save
 
    @hidden_cat = Category.new({:name => "Root Level", :description => "Root Level Category", :private => true})
    @hidden_cat.group = @patroons
    @hidden_cat.user = @admin
    @hidden_cat.save
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_only_admin_can_create_root_category
    session[:username] = @groupie.username
    assert_no_difference('Category.count') do
      post :create, :category => {:name => "Root Level", :description => "Root Level Category", :group => @cool_kids}
    end
    assert_redirected_to root_path 

    session[:username] = @admin.username
    assert_difference('Category.count') do
      post :create, :category => {:name => "Root Level", :description => "Root Level Category", :group => @cool_kids}
    end
    assert_redirected_to category_path(assigns(:category))
  end

  def test_group_member_can_create_sub_category
    session[:username] = @groupie.username
    assert_difference('Category.count') do
      post :create, :category => {:name => "Sub Level", :description => "Second  Level Category", :group => @cool_kids, :parent_id => @cat.id}
    end
    assert_redirected_to category_path(assigns(:category))
  end

  def test_regular_cannot_create_sub_category
    session[:username] = @regular.username
    assert_no_difference('Category.count') do
      post :create, :category => {:name => "Sub Level", :description => "Root Level Category", :group => @cool_kids, :parent_id => @cat.id}
    end
    assert_redirected_to root_path
  end

  def test_should_public_category
    get :show, :id => @cat.id
    assert_response :success
  end

  def test_should_not_see_hidden_category
    session[:username] = nil
    get :show, :id => @hidden_cat.id
    assert_redirected_to root_path

    session[:username] = @regular.username
    get :show, :id => @hidden_cat.id
    assert_redirected_to root_path

    session[:username] = @groupie.username
    get :show, :id => @hidden_cat.id
    assert_redirected_to root_path
 
    session[:username] = @patron.username
    get :show, :id => @hidden_cat.id
    assert_response :success

    session[:username] = @admin.username
    get :show, :id => @hidden_cat.id
    assert_response :success
  end

  def test_should_get_edit
    session[:username] = nil
    get :edit, :id => @cat.id
    assert_redirected_to root_path

    session[:username] = @regular.username
    get :edit, :id => @cat.id
    assert_redirected_to root_path

    session[:username] = @groupie.username
    get :edit, :id => @cat.id
    assert_response :success

    session[:username] = @patron.username
    get :edit, :id => @cat.id
    assert_response :success

    session[:username] = @admin.username
    get :edit, :id => @cat.id
    assert_response :success
  end

  def test_should_update_category
    session[:username] = nil
    put :update, :id => @cat.id, :category => {:name => "Updated!"}
    assert_redirected_to root_path

    session[:username] = @regular.username
    put :update, :id => @cat.id, :category => {:name => "Updated!"}
    assert_redirected_to root_path

    session[:username] = @groupie.username
    put :update, :id => @cat.id, :category => {:name => "Updated!"}
    assert_redirected_to category_path(assigns(:category))

    session[:username] = @patron.username
    put :update, :id => @cat.id, :category => {:name => "Updated!"}
    assert_redirected_to category_path(assigns(:category))

    session[:username] = @admin.username
    put :update, :id => @cat.id, :category => {:name => "Updated!"}
    assert_redirected_to category_path(assigns(:category))
  end

  def test_should_destroy_category
    session[:username] = nil
    assert_no_difference('Category.count') do
      delete :destroy, :id => @hidden_cat.id
    end

    session[:username] = @regular.username
    assert_no_difference('Category.count') do
      delete :destroy, :id => @hidden_cat.id
    end

    session[:username] = @groupie.username
    assert_no_difference('Category.count') do
      delete :destroy, :id => @hidden_cat.id
    end

    session[:username] = @patron.username
    assert_difference('Category.count', -1) do
      delete :destroy, :id => @hidden_cat.id
    end

    session[:username] = @admin.username
    assert_difference('Category.count', -1) do
      delete :destroy, :id => @cat.id
    end
  end
end
