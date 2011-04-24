require 'test_helper'

class FreeChoiceVotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:free_choice_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create free_choice_vote" do
    assert_difference('FreeChoiceVote.count') do
      post :create, :free_choice_vote => { }
    end

    assert_redirected_to free_choice_vote_path(assigns(:free_choice_vote))
  end

  test "should show free_choice_vote" do
    get :show, :id => free_choice_votes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => free_choice_votes(:one).to_param
    assert_response :success
  end

  test "should update free_choice_vote" do
    put :update, :id => free_choice_votes(:one).to_param, :free_choice_vote => { }
    assert_redirected_to free_choice_vote_path(assigns(:free_choice_vote))
  end

  test "should destroy free_choice_vote" do
    assert_difference('FreeChoiceVote.count', -1) do
      delete :destroy, :id => free_choice_votes(:one).to_param
    end

    assert_redirected_to free_choice_votes_path
  end
end
