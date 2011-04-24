class PublicController < ApplicationController
  
  skip_filter :authorize

  #-------#
  # index #
  #-------#
  def index
    @elections = Election.paginate( :conditions => { :mode => "public" }, :page => params[:page], :per_page => $per_page, :order => "created_at DESC" )
  end

  #----------#
  # one_vote #
  #----------#
  def one_vote
    @election = Election.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if @election.blank?

    @selections = Selection.all( :conditions => { :election_id => @election.id } )

    @one_vote = OneVote.first( :conditions => { :election_id => params[:id], :user_id => session[:user_id] } )
    @one_vote = OneVote.new if @one_vote.blank?
  end

  #---------------#
  # one_vote_done #
  #---------------#
  def one_vote_done
    @one_vote = OneVote.first( :conditions => { :election_id => params[:election_id], :user_id => session[:user_id] } )

    unless @one_vote.blank?
      # 更新
      flash[:vote_notice] = @one_vote.update_vote( params[:one_vote] )
    else
      # 新規作成
      flash[:vote_notice] = OneVote.create_vote( params[:one_vote], session[:user_id] )
    end

    redirect_to :action => "one_vote", :id => params[:election_id], :election_page => params[:election_page]
  end

  #------------#
  # three_vote #
  #------------#
  def three_vote
    @election = Election.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if @election.blank?

    @selections = Selection.all( :conditions => { :election_id => @election.id }, :order => "name ASC" )

    three_votes = ThreeVote.all( :select => "selection_id", :conditions => { :election_id => params[:id], :user_id => session[:user_id] } )
    @three_vote = ThreeVote.new
    
    @three_votes = Array.new
    three_votes.each{ |vote| @three_votes.push(vote.selection_id) }
  end

  #-----------------#
  # three_vote_done #
  #-----------------#
  def three_vote_done
    choice_count = 0
    params[:three_vote][:selection_id].each_value{ |value| unless value.blank?; choice_count += 1; end; }
    
    # 投票リセット
    if choice_count == 0
      result = ThreeVote.update_all( { :selection_id => "" }, { :user_id => session[:user_id], :election_id => params[:election_id] } )
      flash[:vote_notice] = "投票のリセットに失敗しました。<br /><br />"
      flash[:vote_notice] = "投票をリセットしました。<br /><br />" if result > 0
      redirect_to :action => "three_vote", :id => params[:election_id], :election_page => params[:election_page] and return
    end

    # 候補選択数チェック
    unless choice_count == 3
      flash[:vote_notice] = "三つの候補に投票して下さい。<br /><br />"
      redirect_to :action => "three_vote", :id => params[:election_id], :election_page => params[:election_page] and return
    end

    three_votes = ThreeVote.all( :conditions => { :election_id => params[:election_id], :user_id => session[:user_id] } )

    unless three_votes.blank?
      # 更新
      flash[:vote_notice] = ThreeVote.update_vote( params[:three_vote], three_votes )
    else
      # 新規作成
      flash[:vote_notice] = ThreeVote.create_vote( params[:three_vote], session[:user_id] )
    end

    redirect_to :action => "three_vote", :id => params[:election_id], :election_page => params[:election_page]
  end

  #-----------#
  # rank_vote #
  #-----------#
  def rank_vote
    @election = Election.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if @election.blank?

    # 候補データ取得
    @selections = Selection.all( :include => :rank_vote, :conditions => { :election_id => @election.id } )

    # 投票データ取得
    @rank_votes = RankVote.all( :include => :selection, :conditions => { :election_id => params[:id], :user_id => session[:user_id] } )

    # 投票データ順位昇順ソート
    @rank_votes = @rank_votes.sort{ |a, b| a.rank <=> b.rank } unless @rank_votes.blank?

    @rank_vote = RankVote.new
  end

  #----------------#
  # rank_vote_done #
  #----------------#
  def rank_vote_done
    if params[:commit] == "リセット"
      # 既存投票削除
      flash[:vote_notice] = RankVote.delete_vote( params[:rank_vote], session[:user_id] )
    else
      # 新規作成／更新
      flash[:vote_notice] = RankVote.create_vote( params[:rank_vote], session[:user_id] )
    end

    redirect_to :action => "rank_vote", :id => params[:election_id], :election_page => params[:election_page]
  end

  #------------------#
  # free_choice_vote #
  #------------------#
  def free_choice_vote
    @election = Election.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if @election.blank?

    @selections = Selection.all( :conditions => { :election_id => @election.id }, :order => "name ASC" )

    free_choice_votes = FreeChoiceVote.all( :select => "selection_id", :conditions => { :election_id => params[:id], :user_id => session[:user_id] } )
    @free_choice_vote = FreeChoiceVote.new
    
    @free_choice_votes = Array.new
    free_choice_votes.each{ |vote| @free_choice_votes.push(vote.selection_id) }
  end

  #-----------------------#
  # free_choice_vote_done #
  #-----------------------#
  def free_choice_vote_done
    # 新規作成
    flash[:vote_notice] = FreeChoiceVote.create_vote( params[:free_choice_vote], session[:user_id] )

    redirect_to :action => "free_choice_vote", :id => params[:election_id], :election_page => params[:election_page]
  end

  #---------------#
  # good_bad_vote #
  #---------------#
  def good_bad_vote
    @election = Election.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if @election.blank?

    @selections = Selection.all( :conditions => { :election_id => @election.id } )

    @good_bad_vote = GoodBadVote.new
    @good_bad_vote_hash = Hash.new
    good_bad_votes = GoodBadVote.all( :conditions => { :election_id => params[:id], :user_id => session[:user_id] } )
    good_bad_votes.each{ |vote| @good_bad_vote_hash[vote.selection_id] = vote.choice }
  end

  #--------------------#
  # good_bad_vote_done #
  #--------------------#
  def good_bad_vote_done
    # 新規作成／更新
    flash[:vote_notice] = GoodBadVote.create_vote( params[:good_bad_vote], session[:user_id] )

    redirect_to :action => "good_bad_vote", :id => params[:election_id], :election_page => params[:election_page]
  end

end
