require 'test_helper'

class ThreeVotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:three_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create three_vote" do
    assert_difference('ThreeVote.count') do
      post :create, :three_vote => { }
    end

    assert_redirected_to three_vote_path(assigns(:three_vote))
  end

  test "should show three_vote" do
    get :show, :id => three_votes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => three_votes(:one).to_param
    assert_response :success
  end

  test "should update three_vote" do
    put :update, :id => three_votes(:one).to_param, :three_vote => { }
    assert_redirected_to three_vote_path(assigns(:three_vote))
  end

  test "should destroy three_vote" do
    assert_difference('ThreeVote.count', -1) do
      delete :destroy, :id => three_votes(:one).to_param
    end

    assert_redirected_to three_votes_path
  end
end
