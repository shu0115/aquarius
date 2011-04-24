require 'test_helper'

class GoodBadVotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:good_bad_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create good_bad_vote" do
    assert_difference('GoodBadVote.count') do
      post :create, :good_bad_vote => { }
    end

    assert_redirected_to good_bad_vote_path(assigns(:good_bad_vote))
  end

  test "should show good_bad_vote" do
    get :show, :id => good_bad_votes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => good_bad_votes(:one).to_param
    assert_response :success
  end

  test "should update good_bad_vote" do
    put :update, :id => good_bad_votes(:one).to_param, :good_bad_vote => { }
    assert_redirected_to good_bad_vote_path(assigns(:good_bad_vote))
  end

  test "should destroy good_bad_vote" do
    assert_difference('GoodBadVote.count', -1) do
      delete :destroy, :id => good_bad_votes(:one).to_param
    end

    assert_redirected_to good_bad_votes_path
  end
end
