require 'test_helper'

class SelectionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:selections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create selection" do
    assert_difference('Selection.count') do
      post :create, :selection => { }
    end

    assert_redirected_to selection_path(assigns(:selection))
  end

  test "should show selection" do
    get :show, :id => selections(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => selections(:one).to_param
    assert_response :success
  end

  test "should update selection" do
    put :update, :id => selections(:one).to_param, :selection => { }
    assert_redirected_to selection_path(assigns(:selection))
  end

  test "should destroy selection" do
    assert_difference('Selection.count', -1) do
      delete :destroy, :id => selections(:one).to_param
    end

    assert_redirected_to selections_path
  end
end
