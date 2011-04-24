require 'test_helper'

class OneVotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:one_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create one_vote" do
    assert_difference('OneVote.count') do
      post :create, :one_vote => { }
    end

    assert_redirected_to one_vote_path(assigns(:one_vote))
  end

  test "should show one_vote" do
    get :show, :id => one_votes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => one_votes(:one).to_param
    assert_response :success
  end

  test "should update one_vote" do
    put :update, :id => one_votes(:one).to_param, :one_vote => { }
    assert_redirected_to one_vote_path(assigns(:one_vote))
  end

  test "should destroy one_vote" do
    assert_difference('OneVote.count', -1) do
      delete :destroy, :id => one_votes(:one).to_param
    end

    assert_redirected_to one_votes_path
  end
end
