require 'test_helper'

class RankVotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rank_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rank_vote" do
    assert_difference('RankVote.count') do
      post :create, :rank_vote => { }
    end

    assert_redirected_to rank_vote_path(assigns(:rank_vote))
  end

  test "should show rank_vote" do
    get :show, :id => rank_votes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => rank_votes(:one).to_param
    assert_response :success
  end

  test "should update rank_vote" do
    put :update, :id => rank_votes(:one).to_param, :rank_vote => { }
    assert_redirected_to rank_vote_path(assigns(:rank_vote))
  end

  test "should destroy rank_vote" do
    assert_difference('RankVote.count', -1) do
      delete :destroy, :id => rank_votes(:one).to_param
    end

    assert_redirected_to rank_votes_path
  end
end
